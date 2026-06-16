$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://+:8080/")
$listener.Start()
Write-Host "Server started on port 8080"
while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response
    $filePath = "c:\Users\Наталья\Documents\product\mai-html" + $request.Url.LocalPath
    if ($request.Url.LocalPath -eq "/") { $filePath += "vizitka.html" }
    if (Test-Path $filePath) {
        $content = [System.IO.File]::ReadAllBytes($filePath)
        $response.ContentType = "text/html; charset=utf-8"
        $response.ContentLength64 = $content.Length
        $response.OutputStream.Write($content, 0, $content.Length)
    } else {
        $response.StatusCode = 404
    }
    $response.OutputStream.Close()
}
