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
        }
    }
}
