<#
.SYNOPSIS
    Indents Groups
.DESCRIPTION
    Prettifies a ScriptBlock by indenting the groups within it.

.NOTES
    This Prettifier uses the `[PSParser]`

    1. GroupStart/GroupEnd will be used to calculate depth.
    2. Depth will be used to determine the desired indentation.
    3. Each line between various points of depth should be indented to that point.
.EXAMPLE
    PSPrettify {
            these lines are indented more than they need to be.
            if (there was a statement) {
             it should be indented   
            }
    }    

#>
[Reflection.AssemblyMetadata("Rank","100")]
param(
# The [ScriptBlock] to prettify
[Parameter(Mandatory)]
[Scriptblock]
$ScriptBlock,

# The amount of indentation to use for each group.  By default, 4.
[int]
$Indent = 4,

# The initial depth.  By default, zero.
[int]
$Depth = 0
)

process {
    # Get all of the tokens in the script
    $tokens = [Management.Automation.PSParser]::Tokenize($ScriptBlock, [ref]$null)
    
    # Determine all of the group indeces
    $groupIndeces = 
        @(for ($tn = 0 ; $tn -lt $tokens.Count; $tn++) {
            if ($tokens[$tn].Type -in 'GroupStart', 'GroupEnd') {
                $tn        
            }
            elseif ($tokens[$tn].Type -eq 'Operator' -and 
                $tokens[$tn].Content -in '[', ']') {
                $tn
            }
        })
    
    # Create a new stringbuilder
    $stringBuilder = [Text.StringBuilder]::new()
    # and stringify the scriptblock
    $text          = "$scriptBlock"    
    $index         = 0
    # Now, walk over each group index
    foreach ($groupIndex in $groupIndeces) {
        $groupToken = $tokens[$groupIndex]
        # Determine if it is a start or an end.
        $isGroupStart = 
            $groupToken.Type -eq 'GroupStart' -or $groupToken.Content -eq '['
        $isGroupEnd = 
            $groupToken.Type -eq 'GroupEnd' -or $groupToken.Content -eq ']'
        
        # find all of the text between now and the last token
        $TextBetween = 
            $text.Substring($index, $groupToken.Start - $index)        

        # indent that text based off the current $depth
        $null =
            $stringBuilder.Append((Push-Indent -Text $TextBetween -Indent ($indent * $depth)))
        
        
        # If the group was at the start of the line
        $null = if ($tokens[$groupIndex - 1].Type -eq 'Newline') {
            if ($isGroupStart) {
                # indent group starts by the current depth
                $stringBuilder.Append(' ' * ($indent * $depth))
            } elseif ($isGroupEnd) {
                $depthModifier = -1
                do {
                    $depthModifier++
                } while (
                    $tokens[$groupIndex + $depthModifier].Type -eq 'GroupEnd' -or 
                    $tokens[$groupIndex + $depthModifier].Content -eq ']'
                )                
                # or indent group ends by the current minus one.
                $stringBuilder.Append(' ' * ($indent * ($depth - $depthModifier)))
            }            
        }
        # add the grouping token.
        $null = $stringBuilder.Append($groupToken.Content)    
        
        if ($IsGroupEnd -and $tokens[$groupIndex + 1].Type -eq 'keyword') {
            $null = $stringBuilder.Append(' ')
        }

        # If the token was a group start
        if ($isGroupStart) {
            $depth++ # increment depth
        } else { # otherwise
            $depth-- # decrement depth.
        }
        $index = $groupToken.Start + $groupToken.Length
    }

    # If there was any remaining text
    if ($index -lt $text.Length) {
        # include it with the current -Indent level.
        $TextBetween = 
            $text.Substring($index)        
        $null =
            $stringBuilder.Append((Push-Indent -Text $TextBetween -Indent ($indent * $depth) -SingleLine))
    }

    try {
        [ScriptBlock]::Create("$stringBuilder")
    } catch {
        $_
        "$stringBuilder"
    }
}
