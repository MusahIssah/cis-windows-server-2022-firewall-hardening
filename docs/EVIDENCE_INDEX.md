# Evidence Index and Original Filename Register

[Overview](../README.md) · [Publication instructions](../evidence/README.md)

**Original evidence filenames were not supplied.** The entries below identify the expected evidence categories without inventing filenames or implying that screenshots exist. No screenshots, raw diagnostics, or new collector output are included in this update.

| Reference | Required supporting context | Original filename | Publication status / location |
| --- | --- | --- | --- |
| E01 | Pre-deployment locally enabled inbound rule review and Ethernet DomainAuthenticated observation | Not supplied | Pending sanitized evidence in `evidence/` |
| E02 | Before-state: all profiles enabled; Public AllowLocalFirewallRules and AllowLocalIPsecRules True | Not supplied | Pending sanitized evidence in `evidence/` |
| E03 | GPO name, Pilot OU link, and scope to SRV01 computer account | Not supplied | Pending sanitized evidence in `evidence/` |
| E04 | GPO Public rule-merging options both No | Not supplied | Pending sanitized evidence in `evidence/` |
| E05 | Final ActiveStore Public Enabled True; both merging values False; applied hardening GPO in computer-scope gpresult | Not supplied | Pending sanitized evidence in `evidence/` |
| E06 | Domain and Private profile preservation | Not supplied | Pending sanitized evidence in `evidence/` |

Rows describe evidence needs, not a claimed screenshot count. A single real capture may support multiple rows; multiple captures may be needed for one row. Once files are supplied, record the exact original filenames, public sanitized filenames, source context, and any crop/redaction. Keep original files private and unchanged.

## Sanitized publication procedure

1. Review actual source captures before copying anything to the repository. Never fabricate screens or reconstruct a historical before-state.
2. Exclude credentials, internal domain information, IP addresses, identifiers, unrelated accounts, and security-sensitive raw output. Retain approved lab labels only where needed to explain the project.
3. Publish flattened cropped/redacted copies and inspect saved images, including metadata. Never publish a proprietary full CIS Benchmark PDF, GPO backup, or unreviewed `gpresult`/rule dump.
4. Add actual image links beneath the matching assessment or change-validation section and replace the pending filename fields with real names. Verify relative paths before committing.
5. Preserve the distinction between effective configuration, GPO application, and untested traffic behavior. Screenshots must not imply an official CIS-CAT scan or resolution of the unrelated auditing issue.
