# PSPrettifier

PSPrettifier is an extensible prettifier for PowerShell.

You can make any script a little bit nicer by using PSPrettifier:

~~~PowerShell
Install-Module PSPrettifier -Scope CurrentUser
Import-Module PSPrettifier
PSPrettify {
    "this script is a little more indented than it needs to be"
    if ($thereIsABlock) {
        "it should also be indented"
    }
}
~~~


Prettification is done using a series of Prettifier scripts.

You can list prettifiers using:

~~~PowerShell
Get-Prettifier
~~~


|Name                                                                         |Synopsis      |
|-----------------------------------------------------------------------------|--------------|
|[IndentGroups.prettify.ps1.DisplayName](Prettifiers/IndentGroups.prettify.ps1|Indents Groups|







