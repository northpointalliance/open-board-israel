$mdPath = Join-Path $PSScriptRoot "..\docs\israeli-employment-law-reference.md"
$outPath = Join-Path $PSScriptRoot "..\board\law\index.html"
$md = Get-Content $mdPath -Raw -Encoding UTF8

function Slug([string]$t) {
    $t = $t.ToLower() -replace '[^a-z0-9\s-]', ''
    ($t.Trim() -replace '\s+', '-')
}

function Inline([string]$t) {
    $t = [System.Net.WebUtility]::HtmlEncode($t)
    $t = [regex]::Replace($t, '\*\*(.+?)\*\*', '<strong>$1</strong>')
    $t = [regex]::Replace($t, '\[([^\]]+)\]\(([^)]+)\)', '<a href="$2">$1</a>')
    $t
}

$lines = $md -split "`r?`n"
$body = New-Object System.Text.StringBuilder
$inTable = $false
$inUl = $false
$tableRows = @()

function Flush-Table {
    if ($script:tableRows.Count -eq 0) { return }
    [void]$body.AppendLine('<div class="table-wrap"><table>')
    $i = 0
    foreach ($row in $script:tableRows) {
        $cells = ($row.Trim('|') -split '\|') | ForEach-Object { $_.Trim() }
        if ($i -eq 1 -and ($cells -join '') -match '^-+$') { $i++; continue }
        $tag = if ($i -eq 0) { 'th' } else { 'td' }
        if ($i -eq 0) { [void]$body.AppendLine('<thead><tr>') } elseif ($i -eq 2) { [void]$body.AppendLine('<tbody>') }
        if ($tag -eq 'th') {
            [void]$body.AppendLine('<tr>')
            foreach ($c in $cells) { [void]$body.AppendLine("<th>$(Inline $c)</th>") }
            [void]$body.AppendLine('</tr></thead>')
        } else {
            [void]$body.AppendLine('<tr>')
            foreach ($c in $cells) { [void]$body.AppendLine("<td>$(Inline $c)</td>") }
            [void]$body.AppendLine('</tr>')
        }
        $i++
    }
    [void]$body.AppendLine('</tbody></table></div>')
    $script:tableRows = @()
    $script:inTable = $false
}

foreach ($line in $lines) {
    if ($line -match '^\|') {
        if (-not $inUl) { } else { if ($inUl) { [void]$body.AppendLine('</ul>'); $inUl = $false } }
        $inTable = $true
        $tableRows += $line
        continue
    } elseif ($inTable) { Flush-Table }

    if ($line -match '^## (.+)$') {
        if ($inUl) { [void]$body.AppendLine('</ul>'); $inUl = $false }
        $h = $Matches[1]
        $id = Slug $h
        [void]$body.AppendLine("<h2 id=`"$id`">$(Inline $h)</h2>")
        continue
    }
    if ($line -match '^### (.+)$') {
        if ($inUl) { [void]$body.AppendLine('</ul>'); $inUl = $false }
        [void]$body.AppendLine("<h3>$(Inline $Matches[1])</h3>")
        continue
    }
    if ($line -match '^# (.+)$') {
        continue
    }
    if ($line -eq '---') {
        if ($inUl) { [void]$body.AppendLine('</ul>'); $inUl = $false }
        [void]$body.AppendLine('<hr>')
        continue
    }
    if ($line -match '^> (.+)$') {
        if ($inUl) { [void]$body.AppendLine('</ul>'); $inUl = $false }
        [void]$body.AppendLine("<blockquote class=`"pinned`">$(Inline $Matches[1])</blockquote>")
        continue
    }
    if ($line -match '^- (.+)$') {
        if (-not $inUl) { [void]$body.AppendLine('<ul>'); $inUl = $true }
        [void]$body.AppendLine("<li>$(Inline $Matches[1])</li>")
        continue
    }
    if ($line -match '^\d+\. (.+)$') {
        if ($inUl) { [void]$body.AppendLine('</ul>'); $inUl = $false }
        [void]$body.AppendLine("<p>$(Inline $line)</p>")
        continue
    }
    if ([string]::IsNullOrWhiteSpace($line)) {
        if ($inUl) { [void]$body.AppendLine('</ul>'); $inUl = $false }
        continue
    }
    if ($inUl) { [void]$body.AppendLine('</ul>'); $inUl = $false }
    [void]$body.AppendLine("<p>$(Inline $line)</p>")
}
if ($inTable) { Flush-Table }
if ($inUl) { [void]$body.AppendLine('</ul>') }

$html = @"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Israeli Employment Law in English | Open Board Israel</title>
  <meta name="description" content="Plain-English reference to Israeli employment law: minimum wage, severance, notice, dismissal hearings (shimu'a), and employee rights. Community resource — not legal advice.">
  <meta name="geo.region" content="IL">
  <link rel="canonical" href="https://open-board-israel.pages.dev/board/law/">
  <style>
    :root { --bg:#dbeafe; --card:#f8fbff; --text:#0f172a; --muted:#334155; --accent:#1d4ed8; --border:#93c5fd; --focus:#2563eb; --disclaimer-bg:#fef3c7; --disclaimer-border:#d97706; }
    * { box-sizing:border-box; }
    body { font-family:system-ui,-apple-system,"Segoe UI",Roboto,sans-serif; background:var(--bg); color:var(--text); line-height:1.65; margin:0; }
    .skip-link { position:absolute; left:-9999px; top:0; z-index:100; padding:.75rem 1rem; background:var(--accent); color:#fff; font-weight:600; text-decoration:none; }
    .skip-link:focus { left:.5rem; top:.5rem; outline:3px solid var(--focus); }
    a:focus-visible { outline:3px solid var(--focus); outline-offset:2px; }
    .top-nav { background:#0f172a; color:#fff; padding:.65rem 1.25rem; text-align:center; font-size:.95rem; }
    .top-nav a { color:#7dd3fc; font-weight:600; }
    .wrap { max-width:820px; margin:0 auto; padding:1.25rem; }
    .disclaimer { background:var(--disclaimer-bg); border:2px solid var(--disclaimer-border); border-radius:10px; padding:1rem 1.25rem; margin-bottom:1rem; color:#78350f; font-size:.95rem; }
    .content { background:var(--card); border:1px solid var(--border); border-radius:12px; padding:1.5rem; }
    .content h2 { color:#1e3a8a; margin:1.75rem 0 .75rem; font-size:1.25rem; }
    .content h2:first-child { margin-top:0; }
    .content h3 { margin:1.25rem 0 .5rem; font-size:1.05rem; }
    .content p, .content li { color:var(--muted); }
    .pinned { background:#eff6ff; border-left:4px solid var(--accent); padding:.75rem 1rem; margin:1rem 0; }
    .table-wrap { overflow-x:auto; margin:1rem 0; }
    table { width:100%; border-collapse:collapse; font-size:.9rem; }
    th, td { border:1px solid var(--border); padding:.5rem .65rem; text-align:left; vertical-align:top; }
    th { background:#eff6ff; color:var(--text); }
    hr { border:none; border-top:1px solid var(--border); margin:1.5rem 0; }
    footer { text-align:center; margin-top:1.5rem; font-size:.85rem; color:var(--muted); }
    footer a { color:var(--accent); }
  </style>
</head>
<body>
  <a class="skip-link" href="#main">Skip to main content</a>
  <nav class="top-nav" aria-label="Site navigation">
    <a href="/board/">Open Board Israel</a> · <a href="/">Daniel's Corner</a> ·
    <a href="https://docs.google.com/spreadsheets/d/1SaaevFI8h0brfbbkFENciGNd7nIoe9mi_Y20z8Kr0fc/edit#gid=1509050488">Find a labor law attorney</a>
  </nav>
  <div class="wrap">
    <aside class="disclaimer" role="note">
      <strong>Not legal advice.</strong> The site owner and developer are not attorneys. This is a community reference only. Consult a qualified Israeli employment lawyer (עורך דין לדיני עבודה) for your situation.
    </aside>
    <main id="main" class="content">
      <h1>Israeli Employment Law — English Reference</h1>
$($body.ToString())
    </main>
    <footer>
      <p><a href="/board/">Back to Open Board</a> · <a href="https://docs.google.com/spreadsheets/d/1SaaevFI8h0brfbbkFENciGNd7nIoe9mi_Y20z8Kr0fc/edit">Community spreadsheet</a></p>
      <p>Community resource · Not legal advice · Israel</p>
    </footer>
  </div>
</body>
</html>
"@

$dir = Split-Path $outPath
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
[System.IO.File]::WriteAllText($outPath, $html, [System.Text.UTF8Encoding]::new($false))
Write-Output "Wrote $outPath"
