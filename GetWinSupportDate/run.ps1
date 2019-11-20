using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

$PersonalVer = Get-Content -Path $PWD\GetWinSupportDate\WinSupport-Personal.json |
    ConvertFrom-Json

# Interact with query parameters or the body of the request.
$Version = $Request.Query.Version
if (-not $Version) {
    $Version = $Request.Body.Version
}

$Class = $Request.Query.Class
if (-not $Class) {
    $Class = $Request.Body.Class
}
if (-not $Class) {
    $Class = 'Personal'
}

if ($Version) {
    if ($Class -in 'Personal', 'Desktop') {
        $VersionInfo = $PersonalVer.$Version

        if ($VersionInfo) {
            $Status = [HttpStatusCode]::OK
            $Body = $VersionInfo
        } else {
            $Status = [HttpStatusCode]::NoContent
            $Body = "No version information found for $Version with class $Class"
        }
    } else {
        $Status = [HttpStatusCode]::BadRequest
        $Body = "Please pass a valid class, $Class was not found in list 'Personal', 'Desktop'"
    }
}
else {
    $Status = [HttpStatusCode]::BadRequest
    $Body = "Please pass a Version on the query string or in the request body."
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $Status
    Body = $Body
})
