function Push-Indent
{    
    <#
    .SYNOPSIS
        Pushes Indentation
    .DESCRIPTION
        Pushes a block of text to a particular level of indentation.
    .EXAMPLE
        Push-Indent -Indent 2 -Text {
            $a = $b
        }
    #>
    param(
    # The text to indent.
    [string]
    $Text,

    # The amount of indentation to apply to the text.
    [int]
    $Indent,

    # Many languages support heredocs or herestrings, which should not be indented.
    # -HereDocStart describes the start of a herestring.
    # By default, this will match PowerShell herestring starts.
    [Alias('HereStringStart')]
    [Regex]
    $HereDocStart = '@["'']$',

    # Many languages support heredocs or herestrings, which should not be indented.
    # -HereDocEnd describes the start of a herestring.
    # By default, this will match PowerShell herestring starts.
    [Alias('HereStringEnd')]
    [Regex]
    $HereDocEnd = '^["'']@',

    # Many languages support multiline comments, which should not be indented.
    # -CommentStart describes the start of a multiline comment.
    # By default, this will match PowerShell multiline comment starts.
    [Regex]
    $CommentStart = '\<\#',

    # Many languages support multiline comments, which should not be indented.
    # -CommentEnd describes the start of a multiline comment.
    # By default, this will match PowerShell multiline comment ends.
    [Regex]
    $CommentEnd  = '\#\>',

    # If set, will indent even if the content is a single line.
    [Alias('FirstLine')]
    [switch]
    $SingleLine
    )

    process {
        $poppedText = Pop-Indent -Text $text -SingleLine:$SingleLine
        $text = $poppedText
        $textLines =@($text -split '[\r\n]+')
        if ($textLines.Length -eq 1 -and -not $SingleLine) { 
            return $text
        }
        
        $InHereDoc = $false        
        $newText = 
            @(foreach ($textLine in $textLines) {                
                if (-not $InHereDoc) {
                    if ($textLine -notmatch '^\s{0,}$') {
                        (' ' * $Indent) + $textLine
                    } else {
                        ''
                    }
                } else {
                    $textLine
                }
            
                if ($textLine -match $HereDocStart -or $textLine -match $CommentStart) {
                    $InHereDoc = $true
                } elseif ($textLine -match $HereDocEnd -or $textLine -match $commentEnd) {
                    $InHereDoc = $false
                }
            }) -join [Environment]::NewLine
        

        $newText
    }
}

