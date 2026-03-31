$ErrorActionPreference = "Continue"

$images = @{
    "assets\images\trincomalee.jpg" = "https://loremflickr.com/1200/800/srilanka,ocean"
    "assets\images\polonnaruwa.jpg" = "https://loremflickr.com/1200/800/srilanka,ruins"
    "assets\images\adams-peak.jpg" = "https://loremflickr.com/1600/800/srilanka,mountain"
}

foreach ($item in $images.GetEnumerator()) {
    $path = $item.Key
    $url = $item.Value
    Write-Host "Downloading $path..."
    try {
        Invoke-WebRequest -Uri $url -OutFile $path -ErrorAction Stop
    } catch {
        Write-Host "Error downloading $path"
    }
}
Write-Host "New Sri Lankan location pictures loaded!"
