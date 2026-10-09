# Regenerates keymap-drawer/toucan.yaml and toucan.svg from config/toucan.keymap.
# Needs uv (https://docs.astral.sh/uv/); keymap-drawer is fetched on demand.
$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
$root = Split-Path $here -Parent
$kd = @('--python', '3.12', '--from', 'keymap-drawer', 'keymap', '-c', "$here/config.yaml")

$parsed = uvx @kd parse -z "$root/config/toucan.keymap" -c 12
if ($LASTEXITCODE) { throw 'keymap parse failed' }

# Swap the placeholder layout line for the Toucan2's 3x12 split grid plus 6 thumb keys.
$layout = (Get-Content "$here/layout.yaml" -Raw).TrimEnd()
$yaml = ($parsed -join "`n") -replace '(?m)^layout:.*$', $layout
Set-Content -Path "$here/toucan.yaml" -Value $yaml -Encoding utf8

uvx @kd draw "$here/toucan.yaml" | Set-Content -Path "$here/toucan.svg" -Encoding utf8
if ($LASTEXITCODE) { throw 'keymap draw failed' }

# Optional PNG export through headless Edge (no extra tooling needed on Windows).
$edge = "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe"
if (Test-Path $edge) {
    $svgUrl = 'file:///' + ("$here/toucan.svg").Replace('\', '/')
    & $edge --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=2 `
        --window-size=840,1480 --screenshot="$here\toucan.png" $svgUrl | Out-Null
}
