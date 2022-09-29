foreach ($file in (Get-ChildItem -Path "$psScriptRoot" -Filter "*-*" -Recurse)) {
    if ($file.Extension -ne '.ps1')      { continue }  # Skip if the extension is not .ps1
    if ($file.Name -match '\.[^\.]+\.ps1$') { continue }  # Skip if the file is an unrelated file.
    . $file.FullName
}

