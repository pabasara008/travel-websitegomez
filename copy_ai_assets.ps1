$ErrorActionPreference = "Continue"
$sourceDir = "C:\Users\Aundre Gomez\.gemini\antigravity\brain\fc15a80d-bfa3-437a-b5ae-ee2ca280e2ba"
$targetDir = "c:\Users\Aundre Gomez\OneDrive\Desktop\travel website\assets\images"

$mapping = @{
    "adams_peak*.png" = "adams-peak.jpg"
    "culture*.png" = "culture.jpg"
    "polonnaruwa*.png" = "polonnaruwa.jpg"
    "premium_service*.png" = "premium-service.jpg"
    "sigiriya*.png" = "sigiriya.jpg"
    "signature*.png" = "signature.jpg"
    "trincomalee*.png" = "trincomalee.jpg"
    "yala_safari*.png" = "yala-safari.jpg"
    "mirissa_beach*.png" = "mirissa-beach.jpg"
    "galle_fort*.png" = "galle-fort.jpg"
    "hero*.png" = "hero.jpg"
    "kandy_train*.png" = "kandy-train.jpg"
}

foreach ($item in $mapping.GetEnumerator()) {
    $pattern = $item.Key
    $newName = $item.Value
    
    $files = Get-ChildItem -Path $sourceDir -Filter $pattern | Sort-Object LastWriteTime -Descending
    if ($files.Count -gt 0) {
        $latest = $files[0]
        Copy-Item -Path $latest.FullName -Destination (Join-Path $targetDir $newName) -Force
        Write-Host "Copied $($latest.Name) to $newName"
    } else {
        Write-Host "Warning: No file found for pattern $pattern"
    }
}
Write-Host "Done copying AI generated images!"
