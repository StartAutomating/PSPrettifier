function Expand-ScriptBlock {
    <#
    .Synopsis
        Prettifies a ScriptBlock.
    .Description
        Expands a ScriptBlock into a prettified ScriptBlock.

        Prettification is accomplished using a series of prettifiers.
    .EXAMPLE
        Expand-ScriptBlock -ScriptBlock {
            if (1) {
             if (2) {
               if (3) {

               }
             }
            }
        }
    #>
    [Alias('PSPrettify')]
    param(
    # The ScriptBlock that will be expanded
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ValueFromPipeline)]
    [ScriptBlock]
    $ScriptBlock,

    # A list of prettifiers.
    # If not provided, all prettifiers will be run.    
    [Alias('Prettifiers')]
    [string[]]
    $Prettifier,

    # A collection of parameters.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Collections.IDictionary]
    $Parameter = @{}
    )

    begin {
        $prettifiers = 
            if ($Prettifier) {
                Get-Prettifier -PrettifierName "(?>$($Prettifier -join '|'))" -Match
            } else {
                Get-Prettifier
            }        
    }

    process {
        $justScriptBlock = @{ScriptBlock=$ScriptBlock}
        $allParameters = $justScriptBlock + $Parameter            

        foreach ($prettifyCommand in $prettifiers) {
            $allParameters['ScriptBlock'] = $ScriptBlock
            $couldRun = $prettifyCommand.CouldRun($allParameters)
            if (-not $couldRun.Count) { continue }            
            $updatedScriptBlock = & $prettifyCommand @couldRun
            if ($updatedScriptBlock -is [ScriptBlock]) {
                $scriptBlock        = $updatedScriptBlock
            }
        }

        $ScriptBlock
    }

    end {

    }
}
