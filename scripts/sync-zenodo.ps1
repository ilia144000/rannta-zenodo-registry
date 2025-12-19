$ErrorActionPreference = "Stop"

$records = @(
    @{ name = "rannta-protocol";   doi = "10.5281/zenodo.17989368" },
    @{ name = "ranntaverse";        doi = "10.5281/zenodo.17988923" },
    @{ name = "arcwallet";          doi = "10.5281/zenodo.17989262" },
    @{ name = "ranntaverse-app";    doi = "10.5281/zenodo.17989340" }
)

$baseApi = "https://zenodo.org/api/records"

foreach ($r in $records) {
    Write-Host "Syncing $($r.name)..."

    $dir = "records/$($r.name)"
    New-Item -ItemType Directory -Force -Path $dir | Out-Null

    # Latest record
    $latest = Invoke-RestMethod "$baseApi/?q=doi:`"$($r.doi)`""
    $latest.hits.hits[0] | ConvertTo-Json -Depth 10 | Out-File "$dir/latest.json" -Encoding UTF8

    # Concept DOI
    $conceptDoi = $latest.hits.hits[0].metadata.conceptdoi
    if ($conceptDoi) {
        $concept = Invoke-RestMethod "$baseApi/?q=conceptdoi:`"$conceptDoi`""
        $concept.hits.hits[0] | ConvertTo-Json -Depth 10 | Out-File "$dir/concept.json" -Encoding UTF8
    }

    # Versions
    $recId = $latest.hits.hits[0].id
    $versions = Invoke-RestMethod "$baseApi/$recId/versions"
    $versions | ConvertTo-Json -Depth 10 | Out-File "$dir/versions.json" -Encoding UTF8
}

Write-Host "Zenodo sync completed."
