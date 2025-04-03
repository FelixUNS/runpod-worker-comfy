# Get all text files that might need conversion
$files = Get-ChildItem -Recurse -File | Where-Object {
    $_.Extension -in @('.sh', '.py', '.txt', '.md', '.yml', '.yaml', '.json', '.js', '.ts', '.css', '.html', '.dockerfile', '.env', '.gitignore', '')
}

foreach ($file in $files) {
    Write-Host "Checking $($file.FullName)..."
    
    # Read the content
    $content = Get-Content -Path $file.FullName -Raw
    
    if ($content -and $content.Contains("`r`n")) {
        Write-Host "Converting $($file.FullName) to LF..."
        
        # Convert CRLF to LF
        $newContent = $content.Replace("`r`n", "`n")
        
        # Write back using UTF8 without BOM
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $newContent, $utf8NoBom)
        
        Write-Host "Converted $($file.FullName)" -ForegroundColor Green
    }
}

Write-Host "Done!" -ForegroundColor Green