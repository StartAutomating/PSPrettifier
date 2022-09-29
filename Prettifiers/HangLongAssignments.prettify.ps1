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
# By default, 60 characters.
[Alias('TooLong')]
[int]
$MaximumAssignmentLength = 60,

# The indentation level.
[int]
$Indent = 4
)

process {
    # Find all of the long assignments.
    $longAssignments = $ScriptBlock.Ast.FindAll({
        param($ast)
        $ast -is [Management.Automation.Language.AssignmentStatementAst] -and
        $ast.Right.Extent.ToString().Length -gt $MaximumAssignmentLength
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
        # and indent.
        $longAssignmentIndent = [Regex]::Match($text.Substring(0, $assignmentOffset),
            "^(?<i>\s{0,})", 'RightToLeft').Groups["i"].Length
        # If there's code between assignments
        if ($assignmentOffset -gt $index) {
            # include it as is
            $text.Substring($index, $assignmentOffset - $index - 1)
        }

        # Otherwise, indent the left side
        (Push-Indent -Text ($longAssignment.Left.Extent.ToString() +
            ' =' +
            [Environment]::NewLine # add a newline
        )  -Indent $longAssignmentIndent) +
            # and indent the right side by -Indent.        
            (Push-Indent -Text $longAssignment.Right.Extent.ToString() -Indent ($longAssignmentIndent + $Indent))

        $index = $longAssignment.Extent.EndOffset - $startOffset
    }

    # If there is any remaining content
    if ($index -lt $text.Length) {
        $text.Substring($index) # include it as-is.
    }) -join [Environment]::NewLine

    [ScriptBlock]::Create($newScript)
}
