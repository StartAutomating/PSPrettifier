#require -Module HelpOut
Push-Location $PSScriptRoot
$parentPath = $PSScriptRoot | Split-Path

$PSPrettifierLoaded = Get-Module PSPrettifier
if (-not $PSPrettifierLoaded) {
    $PSPrettifierLoaded = Get-ChildItem -Recurse -Filter "*.psd1" | Where-Object Name -like 'PSPrettifier*' | Import-Module -Name { $_.FullName } -Force -PassThru
}
if ($PSPrettifierLoaded) {
    "::notice title=ModuleLoaded::PSPrettifier Loaded" | Out-Host
} else {
    "::error:: PSPrettifier not loaded" |Out-Host
}
if ($PSPrettifierLoaded) {
    Save-MarkdownHelp -Module $PSPrettifierLoaded.Name -ScriptPath Prettifiers -ReplaceScriptName '\.(?>pretty|prettify|prettifier)\.ps1$','^Prettifiers[\\/]' -ReplaceScriptNameWith "-Prettifier"   -PassThru
}

Pop-Location