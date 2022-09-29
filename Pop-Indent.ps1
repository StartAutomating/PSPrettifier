function Pop-Indent
{
    <#
    .SYNOPSIS
        Pops text indentation.
    .DESCRIPTION
        Pops text indentation.  This removes indentation from text, based off of the first indented line.        
    .NOTES
        If the text has multiple lines, the first non-whitespace line will determine how much indentation is removed.

        This way, if there is nested indentation within the text, it will be unaffected.
    .EXAMPLE
        Pop-Indent '            
            pop indent will trim initial indentation
        '
    #>
    param(
    # The text to outdent
    [string]
    $Text
    )

    process {
        # Split the text into lines
        $textLines =@($text -split '(?>\r\n|\n)')
        # If there was only one line, change nothing
        if ($textLines.Length -eq 1) { return $text }
        # Set the target indentation to zero.
        $targetIndent = 0 

        
        $newlines = # Walk over each line and adjust it's space.
            foreach ($textLine in $textLines) {
                if ($textLine -match '^\s{0}$') { # If the line was only whitespace
                    '' # return a blank line.
                }
                else {
                    # If we have the target indentation,            
                    if ($targetIndent) {
                        # remove that many leading whitespace characters.
                        $textLine -replace "^\s{$targetIndent}"
                    }
                    # Otherwise
                    else {
                        $null = $textLine -match '^(?<i>\s{0,})'
                        # determine the target indentation.
                        $targetIndent = $matches.i.Length
                        # and replace all of the leading whitespacee.
                        $textLine -replace '^\s{0,}'
                    }
                }
            }
        
        # Join all of the new lines together and we have our outdented text.            
        $newlines -join [Environment]::NewLine
    }
}
