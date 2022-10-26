Pop-Indent
----------
### Synopsis
Pops text indentation.

---
### Description

Pops text indentation.  This removes indentation from text, based off of the first indented line.

---
### Examples
#### EXAMPLE 1
```PowerShell
Pop-Indent '            
    pop indent will trim initial indentation
'
```

---
### Parameters
#### **Text**

The text to outdent



> **Type**: ```[String]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:false



---
#### **SingleLine**

If set, will remove indentation from a single line.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
### Syntax
```PowerShell
Pop-Indent [[-Text] <String>] [-SingleLine] [<CommonParameters>]
```
---
### Notes
If the text has multiple lines, the first non-whitespace line will determine how much indentation is removed.

This way, if there is nested indentation within the text, it will be unaffected.
