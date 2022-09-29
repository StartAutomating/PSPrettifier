@{
    Description = "Prettify your PowerShell"
    RootModule  = 'PSPrettifier.psm1'
    ModuleVersion = '0.1'
    Guid = 'd7939a09-a7ab-4657-969c-71f715e052fe'
    Copyright = '2022 Start-Automating'
    Author = 'James Brundage'    
    CompanyName = 'Start-Automating'
    FormatsToProcess = 'PSPrettifier.format.ps1xml'
    PrivateData = @{
        PSData = @{
            ProjectURI = 'https://github.com/StartAutomating/PSPrettifier'
            LicenseURI = 'https://github.com/StartAutomating/PSPrettifier/blob/main/LICENSE'

            Tags = 'Prettifier', 'PipeScript'
            ReleaseNotes = @'
## 0.1:
* Initial Release of PSPrettifier
  * Get-Prettifier will list prettifiers (Fixes #1)
  * Expand-ScriptBlock (aka PSPrettify) will prettify a scriptblock (Fixes #2)
  * Groups will be indented (Fixes #3)
  * Long Assignments should hang (Fixes #4)
---
'@
        }
    }
}
