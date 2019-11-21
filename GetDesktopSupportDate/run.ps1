using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

$PersonalVer = Get-Content -Path $PWD\GetDesktopSupportDate\WinSupport-Personal.json |
    ConvertFrom-Json

# Interact with query parameters or the body of the request.
$Version = $Request.Query.Version
if (-not $Version) {
    $Version = $Request.Body.Version
}

if ($Version) {
    if ($Version -eq 'All') {
        $Status = [HttpStatusCode]::OK
        $Body = $PersonalVer
    } else {
        if ($Version -notlike '10.*' -and $Version.Split('.').Count -gt 2) {
            $Version = $Version.Split('.')[0,1] -join '.'
        } elseif ($Version.Split('.').Count -gt 3) {
            $Version = $Version.Split('.')[0..2] -join '.'
        }

        $VersionInfo = $PersonalVer.$Version

        if ($VersionInfo) {
            $Status = [HttpStatusCode]::OK
            $Body = $VersionInfo
        } else {
            $Status = [HttpStatusCode]::NoContent
            $Body = "No version information found for $Version"
        }
    }
} else {
    $Status = [HttpStatusCode]::BadRequest
    $Body = "Please pass a Version on the query string or in the request body."
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $Status
    Body = $Body
})
