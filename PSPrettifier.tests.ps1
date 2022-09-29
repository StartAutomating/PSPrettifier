#requires -Module Pester

describe PSPrettifier {
    it 'Makes PowerShell code a bit more pretty' {
        (Expand-ScriptBlock -ScriptBlock {
            "This is far too indented"
        }).ToString() | Should -Be '
"This is far too indented"
'
    }    
}
