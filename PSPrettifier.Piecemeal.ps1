#require -Module Piecemeal
Push-Location $PSScriptRoot

Install-Piecemeal -ExtensionNoun 'Prettifier' -ExtensionPattern '\.(?>prettify|prettifier)\.ps1$'-ExtensionTypeName 'Prettifier' -OutputPath '.\Get-Prettifier.ps1'

Pop-Location
