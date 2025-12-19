# scripts\write-index-files.ps1
# Writes README.md, CITATION.cff, schema.jsonld (safe YAML/JSON generation)

$ErrorActionPreference = "Stop"

$RepoUrl        = "https://github.com/ilia144000/rannta-zenodo-archive"
$Website        = "https://rannta.com"
$Marketplace    = "https://ranntaverse.art"
$AppInterface   = "https://ranntaverse.app"
$Telegram       = "https://t.me/Rannta_coin"
$X              = "https://x.com/ranntacoin"
$GithubFounder  = "https://github.com/ilia144000"
$Orcid          = "https://orcid.org/0009-0001-9044-4662"

$DoiProtocol    = "https://doi.org/10.5281/zenodo.17989368"
$DoiRANNTAverse  = "https://doi.org/10.5281/zenodo.17988923"
$DoiArcWallet   = "https://doi.org/10.5281/zenodo.17989262"
$DoiEcosystem   = "https://doi.org/10.5281/zenodo.17989340"

# Optional (concept DOI if you want to show it)
$ConceptProtocol = "https://doi.org/10.5281/zenodo.17988839"

# --- README.md (variables are expanded now) ---
$readme = @"
# RANNTA Zenodo Archive (Canonical DOI Mirror)

This repository mirrors official Zenodo (DataCite) records and version metadata for the RANNTA ecosystem.

## Canonical DOIs (Zenodo)
- **RANNTA Protocol (Primary Entity):** $DoiProtocol
  - Concept DOI (all versions): $ConceptProtocol
- **RANNTAverse (NFT Marketplace):** $DoiRANNTAverse
- **RANNTA ArcWallet (Wallet):** $DoiArcWallet
- **RANNTA Ecosystem Website (ranntaverse.app):** $DoiEcosystem

## Official links
- Website (protocol & identity hub): $Website
- App interface: $AppInterface
- Marketplace: $Marketplace
- Telegram: $Telegram
- X (Twitter): $X
- GitHub (Founder): $GithubFounder

## Repository purpose
- Preserve canonical DOI metadata snapshots (latest, concept, versions) for each Zenodo record.
- Provide a repeatable manual sync workflow using PowerShell.
- Provide a stable reference surface for indexers and knowledge graphs.

## Manual sync
Run from repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\sync-zenodo.ps1
Records layout

records/<component>/latest.json — current published record metadata (Zenodo API)

records/<component>/concept.json — concept metadata (when available)

records/<component>/versions.json — versions listing (Zenodo API)

records/index.json — ecosystem index file (optional)
"@

Set-Content -Path ".\README.md" -Value $readme -Encoding UTF8

--- CITATION.cff (YAML with correct indentation, aligned with your template) ---

$cff = @"
cff-version: 1.2.0
type: software
title: "RANNTA Zenodo Archive (Canonical DOI Mirror)"
message: "If you use this repository, its synced Zenodo metadata snapshots, or its indexing schemas, please cite it as below."
authors:

family-names: Ghafari
given-names: Ilia
orcid: $Orcid
repository-code: $RepoUrl
url: $Website
license: "MIT"
version: "1.0.0"
date-released: "2025-12-19"
abstract: >
A canonical mirror of RANNTA ecosystem Zenodo records (DataCite DOIs), including
versioned JSON metadata snapshots (latest/concept/versions) and indexing-friendly
references for search engines and AI knowledge systems. This repository provides
a manual PowerShell sync workflow using the public Zenodo API.
keywords:

RANNTA

Zenodo

DataCite

DOI

TON

Web3

JSON

Metadata

Knowledge Graph

ORCID
preferred-citation:
type: software
title: "RANNTA Zenodo Archive (Canonical DOI Mirror)"
authors:

family-names: Ghafari
given-names: Ilia
orcid: $Orcid
url: $RepoUrl
version: "1.0.0"
date-released: "2025-12-19"
license: "MIT"
"@

Set-Content -Path ".\CITATION.cff" -Value $cff -Encoding UTF8

--- schema.jsonld (safe JSON generation) ---

$schemaObj = [ordered]@{
"@context" = "https://schema.org
"
"@type" = "Dataset"
"name" = "RANNTA Zenodo Archive (Canonical DOI Mirror)"
"description" = "A GitHub repository that mirrors official Zenodo (DataCite) records and versioned JSON metadata snapshots for the RANNTA ecosystem, enabling indexing via stable DOIs."
"url" = $RepoUrl
"creator" = [ordered]@{
"@type" = "Person"
"name" = "Ilia Ghafari"
"identifier" = $Orcid
"url" = $GithubFounder
}
"keywords" = @("RANNTA","Zenodo","DataCite","DOI","TON","Web3","JSON","Metadata","Knowledge Graph","ORCID")
"sameAs" = @($DoiProtocol,$DoiRANNTAverse,$DoiArcWallet,$DoiEcosystem)
"isBasedOn" = @("https://zenodo.org
")
"mainEntityOfPage" = $RepoUrl
}

$schemaJson = $schemaObj | ConvertTo-Json -Depth 10
Set-Content -Path ".\schema.jsonld" -Value $schemaJson -Encoding UTF8

Write-Host "Index files written: README.md, CITATION.cff, schema.jsonld"