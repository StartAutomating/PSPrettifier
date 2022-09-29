
Prettifiers/IndentGroups.prettify.ps1
-------------------------------------
### Synopsis
Indents Groups

---
### Description

Prettifies a ScriptBlock by indenting the groups within it.

---
### Examples
#### EXAMPLE 1
```PowerShell
PSPrettify {
        these lines are indented more than they need to be.
        if (there was a statement) {
         it should be indented   
        }
}
```

---
### Parameters
#### **ScriptBlock**

The [ScriptBlock] to prettify



> **Type**: ```[ScriptBlock]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:false



---
#### **Indent**

The amount of indentation to use for each group.  By default, 4.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:false



---
#### **Depth**

The initial depth.  By default, zero.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:false



---
### Syntax
```PowerShell
Prettifiers/IndentGroups.prettify.ps1 [-ScriptBlock] &lt;ScriptBlock&gt; [[-Indent] &lt;Int32&gt;] [[-Depth] &lt;Int32&gt;] [&lt;CommonParameters&gt;]
```
---
### Notes
This Prettifier uses the `[PSParser]`

1. GroupStart/GroupEnd will be used to calculate depth.
2. Depth will be used to determine the desired indentation.
3. Each line between various points of depth should be indented to that point.





