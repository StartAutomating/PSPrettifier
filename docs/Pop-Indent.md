
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
Pop-Indent &#39;            
    pop indent will trim initial indentation
&#39;
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
### Syntax
```PowerShell
Pop-Indent [[-Text] &lt;String&gt;] [&lt;CommonParameters&gt;]
```
---
### Notes
If the text has multiple lines, the first non-whitespace line will determine how much indentation is removed.

This way, if there is nested indentation within the text, it will be unaffected.



