<#
.SYNOPSIS
    Hangs long assignment statements.
.DESCRIPTION
    Hangs long assignment statements.
    
    Any assignment statement whose 
.EXAMPLE
    Expand-ScriptBlock {
        $x = "ThisIsASequenceOfStuff", 
            "ThatTakesUpLotsOfSpace", 
            "SoTheAssignmentShouldBeHanging"
    }
#>
param(
# The `[ScriptBlock]` to Prettify.
[Parameter(Mandatory)]
[scriptblock]
$ScriptBlock,

# The threshold of what makes an assignment 'too long'.
# By default, 200 characters.
[Alias('TooLong')]
[int]
$MaximumAssignmentLength = 200,

# The indentation level.
[int]
$Indent = 4
)

process {
    # Find all of the long assignments.
    $longAssignments = $ScriptBlock.Ast.FindAll({
        param($ast)
        $ast -is [Management.Automation.Language.AssignmentStatementAst] -and                
        $ast.Right.Extent.ToString().Length -gt $MaximumAssignmentLength -and
        $ast.Extent -notmatch '[\r\n]{1,}'
    }, $true)

    # Determine the start offset and stringify the script.
    $startOffset = $ScriptBlock.Ast.Extent.StartOffset
    $text = "$scriptBlock"
    $index = 0

    # To create the new script we need to walk over each long assignment.
    $newScript = 
    @(foreach ($longAssignment in $longAssignments) {
        # and determine it's offset 
        $assignmentOffset = $longAssignment.Extent.StartOffset - $startOffset
        $equalIndex = $text.IndexOf("=", $assignmentOffset)
        # and indent.
        $longAssignmentIndent = [Regex]::Match($text.Substring(0, $assignmentOffset),
            "^(?<i>[\s-[\r\n]]{0,})", 'Multiline,RightToLeft').Groups["i"].Length
        $hangingIndent = $longAssignmentIndent + ($equalIndex - $assignmentOffset)
        # If there's code between assignments
        if ($assignmentOffset -gt $index) {
            # include it as is
            $text.Substring($index, $assignmentOffset - $index - 1) -replace '[\s\r\n]+$' + ([Environment]::NewLine)
        }

        $indentedLeft = 
            # Otherwise, indent the left side
            (Push-Indent -Text ($longAssignment.Left.Extent.ToString() +
                ' =' +
                [Environment]::NewLine # add a newline
            )  -Indent ($longAssignmentIndent) -SingleLine)
        
        $indentedRight = (Push-Indent -Text $longAssignment.Right.Extent.ToString() -Indent (
            $longAssignmentIndent + ($equalIndex - $assignmentOffset)
         ) -SingleLine)

        if ($indentedRight -match '[\r\n]') {
             $null = $null
        }

        $indentedLeft + $indentedRight
            # and indent the right side by -Indent.        
            

        $index = $longAssignment.Extent.EndOffset - $startOffset
    }

    # If there is any remaining content
    if ($index -lt $text.Length) {
        $text.Substring($index) # include it as-is.
    }) -join ''

    [ScriptBlock]::Create($newScript)
}
