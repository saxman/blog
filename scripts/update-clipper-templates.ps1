# Regenerates the Obsidian Web Clipper templates in obsidian-web-clipper/ so the
# Interpreter's tag prompt lists every tag currently used in content/posts.
# Re-run after adding new tags, then re-import the templates into Web Clipper.
# Usage: pwsh scripts/update-clipper-templates.ps1
$ErrorActionPreference = 'Stop'
$root = Join-Path $PSScriptRoot '..'
$outDir = Join-Path $root 'obsidian-web-clipper'
$utf8 = [System.Text.UTF8Encoding]::new($false)

# Collect tags from the YAML list in each post's frontmatter.
$tags = Get-ChildItem (Join-Path $root 'content/posts') -Filter *.md | ForEach-Object {
    $text = [IO.File]::ReadAllText($_.FullName, $utf8) -replace "`r`n", "`n"
    if ($text -match '(?s)^---\n(.*?)\n---') {
        [regex]::Matches($Matches[1], '(?m)^tags:\s*\n((?:\s+-\s+.+\n?)+)') |
            ForEach-Object { [regex]::Matches($_.Groups[1].Value, '(?m)^\s+-\s+(.+?)\s*$') } |
            ForEach-Object { $_.Groups[1].Value }
    }
} | Sort-Object -Unique

$topics = $tags | Where-Object { $_ -notlike 'series/*' }
$series = $tags | Where-Object { $_ -like 'series/*' }

$tagPrompt = @"
Choose 2 to 5 tags for this page from this list of topic tags: $($topics -join ', ').
Also add at most one series tag if the page is centered on a single word, phrase, quote, philosopher, scientific idea, or book list: $($series -join ', ').
Rules: use the most specific tag that fits (language/japanese, not language). Do not add a parent tag alongside its child. Only if no listed tag fits the main subject, invent one new lowercase tag in the same parent/child style. Reply with only the tags separated by commas, with no # and no other text.
"@ -replace "`r?`n", ' '

# Post titles are "Topic: Subject", where Topic is a top-level tag (Language, Philosophy, ...).
$topLevel = $topics | ForEach-Object { ($_ -split '/')[0] } | Sort-Object -Unique | ForEach-Object {
    (Get-Culture).TextInfo.ToTitleCase(($_ -replace '-', ' '))
}
$titlePrompt = "a title of the form 'Topic: Subject'. Topic is one of: $($topLevel -join ', '), and should match the top level of the most relevant tag. Subject is the page subject in its usual capitalization, without the site name"

function New-Template([string] $name, [string] $body) {
    [ordered]@{
        schemaVersion     = '0.1.0'
        name              = $name
        behavior          = 'create'
        # Same prompt as the title property, so the filename matches the title (e.g. 2026-11-17-language-petrichor).
        noteNameFormat    = "{{date|date:`"YYYY-MM-DD`"}}-{{`"$titlePrompt`"|kebab|safe_name}}"
        # New clips go straight to posts/ as drafts; remove draft: true to publish.
        path              = 'posts'
        noteContentFormat = $body
        properties        = @(
            [ordered]@{ name = 'title';  value = "{{`"$titlePrompt`"}}"; type = 'text' }
            [ordered]@{ name = 'date';   value = '{{date|date:"YYYY-MM-DDTHH:mm:ssZ"}}'; type = 'datetime' }
            [ordered]@{ name = 'tags';   value = "{{`"$tagPrompt`"}}"; type = 'multitext' }
            [ordered]@{ name = 'source'; value = '{{url}}'; type = 'text' }
            [ordered]@{ name = 'author'; value = '{{author}}'; type = 'text' }
            [ordered]@{ name = 'draft';  value = 'true'; type = 'checkbox' }
        )
        triggers          = @()
        context           = '{{content|slice:0,30000}}'
    }
}

$link = '[{{title}}]({{url}})'
$templates = @{
    'blog-clipping-excerpt.json' = New-Template 'Blog clipping (excerpt)' (
        "$link`n`n" +
        '{{"the one passage from the main article that best defines or explains its subject, copied verbatim and not paraphrased, at most 3 paragraphs"|blockquote}}' +
        "`n`n")
    'blog-clipping-summary.json' = New-Template 'Blog clipping (summary)' (
        "$link`n`n" +
        '{{"a summary of the main article in 2 to 4 sentences, in a neutral encyclopedic tone, in English"}}' +
        "`n`n")
}

foreach ($file in $templates.Keys) {
    $json = $templates[$file] | ConvertTo-Json -Depth 5
    [IO.File]::WriteAllText((Join-Path $outDir $file), ($json -replace "`r`n", "`n") + "`n", $utf8)
}
"Wrote $($templates.Count) templates with $($topics.Count) topic tags and $($series.Count) series tags to $outDir"
