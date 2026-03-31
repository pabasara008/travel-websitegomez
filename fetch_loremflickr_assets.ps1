$ErrorActionPreference = "Continue"

$images = @{
    "assets\images\hero.jpg" = "https://loremflickr.com/1600/1000/srilanka,sigiriya"
    "assets\images\culture.jpg" = "https://loremflickr.com/1200/800/srilanka,temple"
    "assets\images\tea-estate.jpg" = "https://loremflickr.com/1200/800/srilanka,tea"
    "assets\images\luxury-hotel.jpg" = "https://loremflickr.com/1200/800/srilanka,hotel"
    "assets\images\yala-safari.jpg" = "https://loremflickr.com/1200/800/srilanka,elephant"
    "assets\images\mirissa-beach.jpg" = "https://loremflickr.com/1200/800/srilanka,beach"
    "assets\images\sigiriya.jpg" = "https://loremflickr.com/1200/800/srilanka,lionrock"
    "assets\images\galle-fort.jpg" = "https://loremflickr.com/1200/800/srilanka,lighthouse"
    "assets\images\kandy-train.jpg" = "https://loremflickr.com/1200/800/srilanka,train"
    "assets\images\premium-service.jpg" = "https://loremflickr.com/1200/800/srilanka,resort"
    "assets\images\signature.jpg" = "https://loremflickr.com/400/200/srilanka,leopard"
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
Write-Host "All Sri Lanka Flickr images downloaded!"
