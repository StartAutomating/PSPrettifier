<#
.SYNOPSIS
    Normalizes Assignment Statements
.DESCRIPTION
    Normalizes a series of assignment statements.
    
    This Ensures that the equals sign is at a standardized position.
.LINK
    Expand-ScriptBlock
.EXAMPLE
    Expand-ScriptBlock {
        $a = 'a'
        $aa = 'aa'
        $abc = 'abc'
    } -Prettifier NormalizeAssignment
.EXAMPLE
    Expand-ScriptBlock {
        $a = 'a'
        $aa = 'aa'
        if ($a) {
            $ab = 'ab'
            $abc = 'abc'
        }
    }
#>
param(
[Parameter(Mandatory)]
[scriptblock]
$ScriptBlock,

[int]
$Indent = 4
)

begin {
    $myCmd = $MyInvocation.MyCommand
}

process {
    $foundAssignmentSeries =
        $ScriptBlock.Ast.FindAll({
            param($ast)
            if ($ast -isnot [Management.Automation.Language.AssignmentStatementAst]) {
                return $false
            }
            if ($ast.Left -isnot [Management.Automation.Language.VariableExpressionAst]) {
                return $false
            }
            if (-not $ast.Parent.Statements) {
                return $false
            }
            $astStatementIndex = $ast.Parent.Statements.IndexOf($ast)
            if ($ast.Parent.Statements[$astStatementIndex + 1] -and 
                $ast.Parent.Statements[$astStatementIndex + 1] -is [Management.Automation.Language.AssignmentStatementAst]
            ) {
                return $true
            }
        },$true)
    
    if (-not $foundAssignmentSeries) { return $ScriptBlock } 
    $avoidRanges = @()
    $startOffset = $ScriptBlock.Ast.Extent.StartOffset
    $text = "$scriptBlock"
    $index = 0

    $newScript = 
    @(
    foreach ($assignmentSeriesStart in $foundAssignmentSeries) {        
        $assignmentSeriesOffSet = $assignmentSeriesStart.Extent.StartOffset - $startOffset
        if ($assignmentSeriesOffSet -lt $index) {
            continue
        }        
        $assignmentSeriesIndex = $assignmentSeriesStart.Parent.statements.IndexOf($assignmentSeriesStart)
        $maxVariableNameLength = 0
        $firstAssignmentIndent = 0
        
        $assignmentSeries      = 
        @(while (
            $assignmentSeriesStart.Parent.Statements[$assignmentSeriesIndex] -is 
                [Management.Automation.Language.AssignmentStatementAst]
        ) {
            $assignmentStatement  = $assignmentSeriesStart.Parent.Statements[$assignmentSeriesIndex]
            $assignmentStatementOffset = $assignmentStatement.Extent.StartOffset - $startOffset
            $assignmentLeftLength = $assignmentStatement.Left.ToString().Length
            if ($assignmentLeftLength -gt $maxVariableNameLength) {
                $maxVariableNameLength = $assignmentLeftLength
            }
            if (-not $firstAssignmentIndent) {
                $firstAssignmentIndent = [Regex]::Match($text.Substring($index, $assignmentStatementOffset - $index),
                    "^(?<i>[\s-[\r\n]]{0,})", 'Multiline,RightToLeft').Groups["i"].Length
            }
            $assignmentStatement
            $assignmentSeriesIndex++
        })
        
        $firstInSeries = $true
        foreach ($assignmentStatement in $assignmentSeries) {
            $assignmentStatementOffset = $assignmentStatement.Extent.StartOffset - $startOffset
            if ($assignmentStatementOffset -gt $index) {
                $text.Substring($index, $assignmentStatementOffset - $index) -replace '[\s\r\n]+$' + ([Environment]::NewLine)
            }
             
            
            <#if (-not $firstInSeries) {                
                ' ' * $firstAssignmentIndent
            }#>
            $assignmentLeftString = $assignmentStatement.Left.ToString()
            
            $assignmentLeftString.ToString().PadRight($maxVariableNameLength + 1,' ')
            '='
            if ($assignmentStatement.Right.ToString() -notmatch '[\r\n]') {
                ' '
                $indentedAssignment = Push-Indent $assignmentStatement.Right.ToString() -Indent $Indent
            } else {
                [Environment]::NewLine
                $indentedAssignment = Push-Indent $assignmentStatement.Right.ToString() -Indent ($firstAssignmentIndent + $maxVariableNameLength + 3)
            }

            # $indentedAssignment = Push-Indent $assignmentStatement.Right.ToString() -Indent $Indent
            $assignmentRightScriptBlock = [scriptblock]::Create($indentedAssignment)

            & $myCmd.ScriptBlock -ScriptBlock $assignmentRightScriptBlock

            # $assignmentStatement.Right.ToString()
            $index = $assignmentStatement.Extent.EndOffset
            $firstInSeries = $false
        }
    }
    
    if ($index -lt $text.Length) {
        $text.Substring($index)
    }
    )

    [scriptblock]::Create(($newScript -join ''))
}
