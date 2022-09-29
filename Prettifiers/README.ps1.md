This directory contains Prettifiers.

You can list prettifiers using:

~~~PowerShell
Get-Prettifier
~~~

~~~PipeScript{
    Import-Module ../PSPrettifier.psd1

    [PSCustomObject]@{
        Table = Get-Prettifier |
            .Name {
                "[$_.DisplayName]($($_.Name)"
            } .Synopsis
    }
}
~~~


