
Prettifiers/HangLongAssignments.prettify.ps1
--------------------------------------------
### Synopsis
Hangs long assignment statements.

---
### Description

Hangs long assignment statements.

Any assignment statement whose

---
### Examples
#### EXAMPLE 1
```PowerShell
Expand-ScriptBlock {
    $x = &quot;ThisIsASequenceOfStuff&quot;, 
        &quot;ThatTakesUpLotsOfSpace&quot;, 
        &quot;SoTheAssignmentShouldBeHanging&quot;
}
```

---
### Parameters
#### **ScriptBlock**

The `[ScriptBlock]` to Prettify.



> **Type**: ```[ScriptBlock]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:false



---
#### **MaximumAssignmentLength**

The threshold of what makes an assignment 'too long'.
By default, 60 characters.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:false



---
#### **Indent**

The indentation level.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:false



---
### Syntax
```PowerShell
Prettifiers/HangLongAssignments.prettify.ps1 [-ScriptBlock] &lt;ScriptBlock&gt; [[-MaximumAssignmentLength] &lt;Int32&gt;] [[-Indent] &lt;Int32&gt;] [&lt;CommonParameters&gt;]
```
---



