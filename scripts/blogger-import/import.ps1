# One-time import of the Blogger Markdown export into the Quartz vault.
# Usage: pwsh scripts/blogger-import/import.ps1 -Source <extracted export dir>
param(
    [Parameter(Mandatory)] [string] $Source,
    [string] $Dest = (Join-Path $PSScriptRoot '../../content/posts'),
    [string] $Unpublished = (Join-Path $PSScriptRoot '../../../blog-unpublished')
)
$ErrorActionPreference = 'Stop'
$defaultBlog = 'Discoveries, Factoids, and Meandering Thoughts'
$utf8 = [System.Text.UTF8Encoding]::new($false)

function ConvertTo-Slug([string] $text) {
    $plain = -join ($text.Normalize([Text.NormalizationForm]::FormD).ToCharArray() |
        Where-Object { [Globalization.CharUnicodeInfo]::GetUnicodeCategory($_) -ne 'NonSpacingMark' })
    $slug = ($plain.ToLowerInvariant() -replace '[^a-z0-9]+', '-').Trim('-')
    if ($slug.Length -gt 60) { $slug = $slug.Substring(0, 60) -replace '-[^-]*$', '' }
    return $slug
}

New-Item -ItemType Directory -Force $Dest, $Unpublished | Out-Null
$seen = @{}
$counts = @{ published = 0; unpublished = 0 }

foreach ($line in Get-Content (Join-Path $PSScriptRoot 'mapping.txt') -Encoding utf8) {
    if ($line -match '^\s*(#|$)') { continue }
    $file, $newTitle, $tagSpec = $line -split '\s*\|\s*', 3
    $rel = if ($file -like '*/*') { $file } else { "$defaultBlog/$file" }
    $path = Join-Path $Source $rel
    if (-not (Test-Path -LiteralPath $path)) { throw "Missing source file: $rel" }
    $seen[$rel] = $true

    $text = [IO.File]::ReadAllText($path, $utf8) -replace "`r`n", "`n"
    if ($text -notmatch '(?s)^---\n(.*?)\n---\n?(.*)$') { throw "No frontmatter: $rel" }
    $front, $body = $Matches[1], $Matches[2].Trim()

    $origTitle = [regex]::Match($front, '(?m)^title:\s*(.*)$').Groups[1].Value.Trim()
    $date = [regex]::Match($front, '(?m)^date:\s*(.*)$').Groups[1].Value.Trim() -replace '\.\d+Z$', 'Z'
    $status = [regex]::Match($front, '(?m)^status:\s*(.*)$').Groups[1].Value.Trim()

    if ($newTitle -eq '-') {
        $titleYaml = $origTitle
        $titlePlain = $origTitle -replace '^"(.*)"$', '$1' -replace '\\"', '"'
    } else {
        $titlePlain = $newTitle
        $titleYaml = '"' + ($newTitle -replace '"', '\"') + '"'
    }

    $tags = @($tagSpec -split '\s*,\s*' | Where-Object { $_ })
    $isUnpublished = $tags -contains 'unpublished'
    $outName = '{0}-{1}.md' -f $date.Substring(0, 10), (ConvertTo-Slug $titlePlain)

    $fm = @('---', "title: $titleYaml", "date: $date")
    if ($isUnpublished) {
        $fm += 'tags: []', 'draft: true', "blogger_status: $status", "blogger_file: `"$rel`""
        $outDir = $Unpublished; $counts.unpublished++
    } else {
        $fm += 'tags:'
        $fm += $tags | ForEach-Object { "  - $_" }
        $outDir = $Dest; $counts.published++
    }
    $fm += 'imported_from: blogger', '---', ''

    $outPath = Join-Path $outDir $outName
    if (Test-Path -LiteralPath $outPath) { throw "Duplicate output name: $outName (from $rel)" }
    [IO.File]::WriteAllText($outPath, (($fm -join "`n") + "`n" + $body + "`n"), $utf8)
}

# Make sure every exported post is accounted for in the mapping.
$all = Get-ChildItem -LiteralPath $Source -Recurse -Filter *.md |
    ForEach-Object { [IO.Path]::GetRelativePath($Source, $_.FullName) -replace '\\', '/' }
$unmapped = $all | Where-Object { -not $seen.ContainsKey($_) }
if ($unmapped) { throw "Unmapped export files:`n$($unmapped -join "`n")" }

"Imported $($counts.published) posts to $Dest; $($counts.unpublished) to $Unpublished"
