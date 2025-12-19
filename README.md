# RANNTA Zenodo Archive (Canonical DOI Mirror)

This repository mirrors official Zenodo (DataCite) records and version metadata for the RANNTA ecosystem.

## Canonical DOIs (Zenodo)
- **RANNTA Protocol (Primary Entity):** https://doi.org/10.5281/zenodo.17989368
  - Concept DOI (all versions): https://doi.org/10.5281/zenodo.17988839
- **RANNTAverse (NFT Marketplace):** https://doi.org/10.5281/zenodo.17988923
- **RANNTA ArcWallet (Wallet):** https://doi.org/10.5281/zenodo.17989262
- **RANNTA Ecosystem Website (ranntaverse.app):** https://doi.org/10.5281/zenodo.17989340

## Official links
- Website (protocol & identity hub): https://rannta.com
- App interface: https://ranntaverse.app
- Marketplace: https://ranntaverse.art
- Telegram: https://t.me/Rannta_coin
- X (Twitter): https://x.com/ranntacoin
- GitHub (Founder): https://github.com/ilia144000

## Repository purpose
- Preserve canonical DOI metadata snapshots (latest, concept, versions) for each Zenodo record.
- Provide a repeatable manual sync workflow using PowerShell.
- Provide a stable reference surface for indexers and knowledge graphs.

## Manual sync
Run from repository root:

powershell -ExecutionPolicy Bypass -File .\scripts\sync-zenodo.ps1

## Records layout
- records/<component>/latest.json — current published record metadata (Zenodo API)
- records/<component>/concept.json — concept metadata (when available)
- records/<component>/versions.json — versions listing (Zenodo API)
- records/index.json — ecosystem index file (optional)
