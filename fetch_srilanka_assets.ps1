$ErrorActionPreference = "Continue"

$UserAgent = "SriLankaTravelBuilderBot/1.0"

$terms = @{
    "assets\images\hero.jpg" = "Sigiriya sunrise"
    "assets\images\culture.jpg" = "Temple of the Tooth Kandy"
    "assets\images\tea-estate.jpg" = "Nuwara Eliya tea plantations"
    "assets\images\luxury-hotel.jpg" = "Galle Face Hotel"
    "assets\images\yala-safari.jpg" = "Yala elephant"
    "assets\images\mirissa-beach.jpg" = "Mirissa beach Sri Lanka"
    "assets\images\sigiriya.jpg" = "Sigiriya rock fortress"
    "assets\images\galle-fort.jpg" = "Galle fort lighthouse"
    "assets\images\kandy-train.jpg" = "Nine Arch Bridge Ella"
    "assets\images\premium-service.jpg" = "Lotus tower Colombo skyline"
    "assets\images\signature.jpg" = "Sri Lankan leopard Yala"
}

foreach ($item in $terms.GetEnumerator()) {
    $path = $item.Key
    $query = $item.Value
    
    $searchUrl = "https://commons.wikimedia.org/w/api.php?action=query&list=search&srsearch=" + [uri]::EscapeDataString($query) + "&srnamespace=6&format=json"
    
    try {
        $response = Invoke-RestMethod -Uri $searchUrl -UserAgent $UserAgent -ErrorAction Stop
        
        if ($response.query.search.Count -gt 0) {
            $fileTitle = $response.query.search[0].title
            $fileName = $fileTitle.Substring(5) # Remove 'File:' prefix
            
            $downloadUrl = "https://commons.wikimedia.org/wiki/Special:FilePath/" + [uri]::EscapeDataString($fileName) + "?width=1200"
            
            Write-Host "Downloading $fileTitle for $path..."
            Invoke-WebRequest -Uri $downloadUrl -OutFile $path -UserAgent $UserAgent -ErrorAction Stop
        } else {
            Write-Host "No image found for $query"
        }
    } catch {
        Write-Host "Error fetching $query - $($_.Exception.Message)"
    }
    
    Start-Sleep -Seconds 2
}

Write-Host "Sri Lanka specific image download complete!"
