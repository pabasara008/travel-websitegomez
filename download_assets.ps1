$ErrorActionPreference = "Continue"

New-Item -ItemType Directory -Force -Path "assets\images" | Out-Null

$images = @{
    "assets\images\hero.jpg" = "https://images.unsplash.com/photo-1586227740560-8cf2732c1531"
    "assets\images\signature.jpg" = "https://images.unsplash.com/photo-1543880521-06774900aef1" # alternative fallback
    "assets\images\culture.jpg" = "https://images.unsplash.com/photo-1550580973-1954bd61e8cd"
    "assets\images\tea-estate.jpg" = "https://images.unsplash.com/photo-1579606032822-1d5eab893cfa"
    "assets\images\luxury-hotel.jpg" = "https://images.unsplash.com/photo-1620619859265-d01809075ce6"
    "assets\images\yala-safari.jpg" = "https://images.unsplash.com/photo-1583345266710-1c01e6878a87" # replaced
    "assets\images\mirissa-beach.jpg" = "https://images.unsplash.com/photo-1552465011-b4e21bf6e79a"
    "assets\images\sigiriya.jpg" = "https://images.unsplash.com/photo-1625405021272-911855a02e6d"
    "assets\images\galle-fort.jpg" = "https://images.unsplash.com/photo-1546708973-c6cd4addbd40"
    "assets\images\kandy-train.jpg" = "https://images.unsplash.com/photo-1587595431973-160d0d94add1"
    "assets\images\premium-service.jpg" = "https://images.unsplash.com/photo-1546708973-c6cd4addbd40"
}

$fallbackImage = "https://images.unsplash.com/photo-1586227740560-8cf2732c1531"

foreach ($path in $images.Keys) {
    Write-Host "Downloading $path..."
    try {
        Invoke-WebRequest -Uri ($images[$path] + "?q=80&w=1200&auto=format&fit=crop") -OutFile $path -ErrorAction Stop
    } catch {
        Write-Host "Failed to download $path, using fallback..."
        Invoke-WebRequest -Uri ($fallbackImage  + "?q=80&w=1200&auto=format&fit=crop") -OutFile $path
    }
}

Write-Host "All assets downloaded successfully."
