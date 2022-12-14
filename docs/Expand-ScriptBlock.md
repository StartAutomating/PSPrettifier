
Expand-ScriptBlock
------------------
### Synopsis
Prettifies a ScriptBlock.

---
### Description

Expands a ScriptBlock into a prettified ScriptBlock.

Prettification is accomplished using a series of prettifiers.

---
### Examples
#### EXAMPLE 1
```PowerShell
Expand-ScriptBlock -ScriptBlock {
    if (1) {
     if (2) {
       if (3) {
```
}
     }
    }
}
#### EXAMPLE 2
```PowerShell
Expand-ScriptBlock -ScriptBlock {
    if (1) {
    $x = &quot;ThisIsASequenceOfStuff&quot;,
       &quot;ThatTakesUpLotsOfSpace&quot;,
       &quot;SoTheAssignmentShouldBeHanging&quot;, $(
            if ($y) {
                &quot;z&quot;
            }
        )
    }
}
```

---
### Parameters
#### **ScriptBlock**

The ScriptBlock that will be expanded



> **Type**: ```[ScriptBlock]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByValue, ByPropertyName)



---
#### **Prettifier**

A list of prettifiers.
If not provided, all prettifiers will be run.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:false



---
#### **Parameter**

A collection of parameters.



> **Type**: ```[IDictionary]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Expand-ScriptBlock [-ScriptBlock] &lt;ScriptBlock&gt; [[-Prettifier] &lt;String[]&gt;] [[-Parameter] &lt;IDictionary&gt;] [&lt;CommonParameters&gt;]
```
---


