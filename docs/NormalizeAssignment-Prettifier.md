
Prettifiers/NormalizeAssignment.prettify.ps1
--------------------------------------------
### Synopsis
Normalizes Assignment Statements

---
### Description

Normalizes a series of assignment statements.

This Ensures that the equals sign is at a standardized position.

---
### Related Links
* [Expand-ScriptBlock](Expand-ScriptBlock.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Expand-ScriptBlock {
    $a = 'a'
    $aa = 'aa'
    $abc = 'abc'
} -Prettifier NormalizeAssignment
```

#### EXAMPLE 2
```PowerShell
Expand-ScriptBlock {
    $a = 'a'
    $aa = 'aa'
    if ($a) {
        $ab = 'ab'
        $abc = 'abc'
    }
}
```

---
### Parameters
#### **ScriptBlock**

> **Type**: ```[ScriptBlock]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:false



---
#### **Indent**

> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:false



---
### Syntax
```PowerShell
Prettifiers/NormalizeAssignment.prettify.ps1 [-ScriptBlock] <ScriptBlock> [[-Indent] <Int32>] [<CommonParameters>]
```
---



