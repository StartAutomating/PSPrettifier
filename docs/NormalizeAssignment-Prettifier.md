
Prettifiers/NormalizeAssignment.prettify.ps1
--------------------------------------------
### Synopsis


---
### Description
---
### Examples
#### EXAMPLE 1
```PowerShell
Expand-ScriptBlock {
    $a = 'a'
    $aa = 'aa'
    $abc = 'abc'
}
.\NormalizeAssignment.prettify.ps1 -ScriptBlock {
    
}
```

#### EXAMPLE 2
```PowerShell
.\NormalizeAssignment.prettify.ps1 -ScriptBlock {
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




