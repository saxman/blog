# Regenerates the Obsidian Web Clipper templates in obsidian-web-clipper/ so each
# Interpreter tag prompt lists every tag currently used in its vault.
# Re-run after adding new tags, then re-import the templates into Web Clipper.
# Usage: pwsh scripts/update-clipper-templates.ps1
$ErrorActionPreference = 'Stop'
$root = Join-Path $PSScriptRoot '..'
$content = Join-Path $root 'content'
$outDir = Join-Path $root 'obsidian-web-clipper'
$utf8 = [System.Text.UTF8Encoding]::new($false)

# Collect tags from the YAML list in each note's frontmatter under a folder.
function Get-Tags([string] $dir) {
    Get-ChildItem $dir -Filter *.md | ForEach-Object {
        $text = [IO.File]::ReadAllText($_.FullName, $utf8) -replace "`r`n", "`n"
        if ($text -match '(?s)^---\n(.*?)\n---') {
            [regex]::Matches($Matches[1], '(?m)^tags:\s*\n((?:\s+-\s+.+\n?)+)') |
                ForEach-Object { [regex]::Matches($_.Groups[1].Value, '(?m)^\s+-\s+"?(.+?)"?\s*$') } |
                ForEach-Object { $_.Groups[1].Value }
        }
    } | Sort-Object -Unique
}
function Save-Template([string] $file, $template) {
    $json = $template | ConvertTo-Json -Depth 5
    [IO.File]::WriteAllText((Join-Path $outDir $file), ($json -replace "`r`n", "`n") + "`n", $utf8)
}
$link = '[{{title}}]({{url}})'
# Filename slug filters: kebab-case and lowercase, turn leftover punctuation into hyphens, then collapse and
# trim hyphens. Letters with accents are kept (Web Clipper can't transliterate them).
# (No "|" or double quotes inside the regexes: Web Clipper would misread them.)
$slugFilters = '|kebab|lower|replace:"/[()\[\]{},.!?:;&]+/g":"-"|replace:"/-+/g":"-"|replace:"/^-/":""|replace:"/-$/":""|safe_name'

# --- Meanderings (the blog): "Topic: Subject" posts in meanderings/posts ---
$tags = Get-Tags (Join-Path $content 'meanderings/posts')
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

function New-PostTemplate([string] $name, [string] $body) {
    [ordered]@{
        schemaVersion     = '0.1.0'
        name              = $name
        behavior          = 'create'
        vault             = 'meanderings'
        # Same prompt as the title property, so the filename matches the title (e.g. 2026-11-17-language-petrichor).
        noteNameFormat    = "{{date|date:`"YYYY-MM-DD`"}}-{{`"$titlePrompt`"$slugFilters}}"
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
Save-Template 'meanderings-excerpt.json' (New-PostTemplate 'Meanderings (excerpt)' (
    "$link`n`n" +
    '{{"the one passage from the main article that best defines or explains its subject, copied verbatim and not paraphrased, at most 3 paragraphs"|blockquote}}' +
    "`n`n"))
Save-Template 'meanderings-summary.json' (New-PostTemplate 'Meanderings (summary)' (
    "$link`n`n" +
    '{{"a summary of the main article in 2 to 4 sentences, in a neutral encyclopedic tone, in English"}}' +
    "`n`n"))

# --- Reference vaults: one note per bookmark in <vault>/references ---
$refVaults = [ordered]@{
    'engineering'   = @{ label = 'Engineering reference'; prefix = 'engineering/';
                         triggers = @('https://arxiv.org/', 'https://github.com/', 'https://huggingface.co/') }
    'public-health' = @{ label = 'Public health reference'; prefix = 'public-health/'; triggers = @() }
}
# Tags from every reference vault, so a reference can be cross-listed (e.g. an AI paper about disease modeling).
$allRefTags = $refVaults.Keys | ForEach-Object { Get-Tags (Join-Path $content "$_/references") } | Sort-Object -Unique
$kinds = 'paper, article, repo, tool, project, model, dataset, program, course, link'
$refTitlePrompt = 'the name of the paper, tool, project, or article, as it is usually written, without the site name'

foreach ($v in $refVaults.Keys) {
    $cfg = $refVaults[$v]
    $refTagPrompt = (@"
Choose 1 to 4 tags for this page from this list: $($allRefTags -join ', ').
At least one tag must start with $($cfg.prefix). Use the most specific tag that fits, and do not add a parent tag alongside its child.
Only if no listed tag fits the main subject, invent one new lowercase tag under $($cfg.prefix) in the same style. Reply with only the tags separated by commas, with no # and no other text.
"@ -replace "`r?`n", ' ')
    Save-Template "$v-reference.json" ([ordered]@{
        schemaVersion     = '0.1.0'
        name              = $cfg.label
        behavior          = 'create'
        vault             = $v
        noteNameFormat    = "{{date|date:`"YYYY-MM-DD`"}}-{{`"$refTitlePrompt`"$slugFilters}}"
        path              = 'references'
        noteContentFormat = "$link`n`n" + '{{"a description of what this is and why it matters, in 2 to 3 sentences, in a neutral tone, in English"}}' + "`n`n"
        properties        = @(
            [ordered]@{ name = 'title';      value = "{{`"$refTitlePrompt`"}}"; type = 'text' }
            [ordered]@{ name = 'date';       value = '{{date|date:"YYYY-MM-DD"}}'; type = 'date' }
            [ordered]@{ name = 'published';  value = '{{published|date:"YYYY-MM-DD"}}'; type = 'date' }
            [ordered]@{ name = 'tags';       value = "{{`"$refTagPrompt`"}}"; type = 'multitext' }
            [ordered]@{ name = 'type';       value = "{{`"which one of these best describes the page: $kinds. Reply with only that word`"}}"; type = 'text' }
            [ordered]@{ name = 'source';     value = '{{url}}'; type = 'text' }
            [ordered]@{ name = 'author';     value = '{{author}}'; type = 'text' }
            [ordered]@{ name = 'summary_by'; value = 'ai'; type = 'text' }
            [ordered]@{ name = 'draft';      value = 'true'; type = 'checkbox' }
        )
        triggers          = $cfg.triggers
        context           = '{{content|slice:0,30000}}'
    })
}

"Wrote templates: blog ($($topics.Count) topic and $($series.Count) series tags), references ($($allRefTags.Count) tags) to $outDir"
