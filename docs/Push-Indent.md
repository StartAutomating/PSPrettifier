Push-Indent
-----------
### Synopsis
Pushes Indentation

---
### Description

Pushes a block of text to a particular level of indentation.

---
### Examples
#### EXAMPLE 1
```PowerShell
Push-Indent -Indent 2 -Text {
    $a = $b
}
```

---
### Parameters
#### **Text**

The text to indent.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:false



---
#### **Indent**

The amount of indentation to apply to the text.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:false



---
#### **HereDocStart**

Many languages support heredocs or herestrings, which should not be indented.
-HereDocStart describes the start of a herestring.
By default, this will match PowerShell herestring starts.



> **Type**: ```[Regex]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:false



---
#### **HereDocEnd**

Many languages support heredocs or herestrings, which should not be indented.
-HereDocEnd describes the start of a herestring.
By default, this will match PowerShell herestring starts.



> **Type**: ```[Regex]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:false



---
#### **CommentStart**

Many languages support multiline comments, which should not be indented.
-CommentStart describes the start of a multiline comment.
By default, this will match PowerShell multiline comment starts.



> **Type**: ```[Regex]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:false



---
#### **CommentEnd**

Many languages support multiline comments, which should not be indented.
-CommentEnd describes the start of a multiline comment.
By default, this will match PowerShell multiline comment ends.



> **Type**: ```[Regex]```

> **Required**: false

> **Position**: 6

> **PipelineInput**:false



---
#### **SingleLine**

> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
### Syntax
```PowerShell
Push-Indent [[-Text] <String>] [[-Indent] <Int32>] [[-HereDocStart] <Regex>] [[-HereDocEnd] <Regex>] [[-CommentStart] <Regex>] [[-CommentEnd] <Regex>] [-SingleLine] [<CommonParameters>]
```
---
