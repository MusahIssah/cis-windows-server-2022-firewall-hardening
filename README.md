# CIS Windows Server 2022 Firewall Assessment & Group Policy Hardening

**Windows Server 2022 · Active Directory · Group Policy · PowerShell · Configuration assessment**

## Overview

This lab assessed **five selected firewall checks** from the **CIS Microsoft Windows Server 2022 Benchmark v5.1.0, Level 1 Member Server**, on **SRV01**, a Windows Server 2022 member server managed through **DC01**, Active Directory, and Group Policy.

Two Public profile rule-merging settings failed the initial review. A targeted Group Policy change disabled both settings, and independent effective-configuration checks verified the resulting state and applied GPO. Both findings are **remediated at the effective-configuration level**.

These are selected configuration validations, **not official CIS-CAT results**, a full benchmark assessment, or a compliance certification. Results reflect the author's supplied observations; repository authoring did not rerun the lab checks.

## Business scenario

A team needs to prevent local Public profile firewall and connection security rules from merging with centrally managed policy on a member server. The change must be narrowly scoped to the pilot computer, preserve Domain and Private profile settings, and be verified independently of the policy editor.

## Architecture

```mermaid
flowchart LR
    DC[DC01: Active Directory and Group Policy] --> GPO[CIS-SRV01-Public-Firewall-Hardening]
    GPO -->|Linked to Pilot OU| OU[Pilot OU]
    OU -->|Scope: SRV01 computer account| SRV[SRV01: Windows Server 2022 member server]
    SRV --> PUBLIC[Public profile: both local rule-merging settings disabled]
    SRV --> VERIFY[ActiveStore verification and applied GPO review]
```

This logical diagram does not establish a broader network topology. Ethernet was **DomainAuthenticated** during the pre-deployment review; Public profile configuration was assessed without claiming a Public-network traffic test.

## Methodology and change validation

1. Review five selected firewall checks on SRV01 and record effective configuration.
2. Before deployment, inspect locally enabled inbound rules and confirm Ethernet's network category was DomainAuthenticated. The reviewed rules and a traffic-impact test result were not supplied.
3. Create `CIS-SRV01-Public-Firewall-Hardening`, link it to **Pilot OU**, and scope it to the **SRV01 computer account**.
4. Configure the Public profile's **Apply local firewall rules** and **Apply local connection security rules** options to **No**. Preserve Domain and Private profile settings.
5. Independently verify effective settings and the applied computer GPO list using the commands below. No specific policy refresh command or deployment timestamp was supplied.

```powershell
Get-NetFirewallProfile -PolicyStore ActiveStore |
    Select-Object Name, Enabled, AllowLocalFirewallRules, AllowLocalIPsecRules

gpresult /r /scope computer
```

The final Public profile was **Enabled True**, **AllowLocalFirewallRules False**, and **AllowLocalIPsecRules False**. The applied GPO list included **CIS-SRV01-Public-Firewall-Hardening**. This verifies effective settings and GPO application; it does not establish packet filtering behavior under a Public network category or the removal of local rule definitions.

## Before and after

| Selected CIS check | Effective property / target | Before | Initial result | After | Final result |
| --- | --- | --- | --- | --- | --- |
| 9.1.1 Domain Firewall Enabled | Domain Enabled = True | True | Pass | True | Pass |
| 9.2.1 Private Firewall Enabled | Private Enabled = True | True | Pass | True | Pass |
| 9.3.1 Public Firewall Enabled | Public Enabled = True | True | Pass | True | Pass |
| 9.3.4 Public Apply local firewall rules | Public AllowLocalFirewallRules = False | True | Fail | False | Pass |
| 9.3.5 Public Apply local connection security rules | Public AllowLocalIPsecRules = False | True | Fail | False | Pass |

The Domain and Private profile settings were preserved. The table represents **only these five selected effective-configuration checks**, not an overall CIS score.

## Findings

| Finding | Initial observation | Recorded remediation | Status |
| --- | --- | --- | --- |
| CIS-FW-01 | Public AllowLocalFirewallRules True | Targeted GPO set local firewall rule merging to No; effective value False | Remediated — effective configuration |
| CIS-FW-02 | Public AllowLocalIPsecRules True | Targeted GPO set local connection security rule merging to No; effective value False | Remediated — effective configuration |

See [finding records](docs/FINDINGS.md) and the [assessment report](docs/ASSESSMENT_REPORT.md). No exploit, unauthorized rule, or security incident is asserted.

## Read-only baseline script

[scripts/check-firewall-baseline.ps1](scripts/check-firewall-baseline.ps1) reads ActiveStore, evaluates the five selected targets, and saves a timestamped JSON report. It does not change firewall settings, rules, services, network categories, GPOs, or policy refresh state.

Run on the intended server in Windows PowerShell 5.1 with permission to read firewall state and write to the chosen existing output directory:

```powershell
.\scripts\check-firewall-baseline.ps1 -OutputDirectory $env:TEMP
```

The report includes collection time and selected settings, not host/domain identifiers or raw `gpresult` output. The script writes a local report file; it makes no policy changes or network requests. Errors stop collection rather than fabricating Pass/Fail results. A returned value other than explicit True or False is **Review required**, not a pass. Do not run it with an output directory you cannot write to, and inspect output before publication.

**Repository validation:** Windows PowerShell 5.1 syntax parsing passed for the script, both PowerShell examples parsed successfully, and 18 relative Markdown links passed validation. These are authoring checks, not endpoint security test results. Execution of this newly authored script on SRV01 is not claimed, and no generated report is included as lab evidence.

## Evidence and documentation

| Resource | Purpose |
| --- | --- |
| [Assessment report](docs/ASSESSMENT_REPORT.md) | Scope, observations, change, validation, and residual limitations |
| [Findings](docs/FINDINGS.md) | CIS-FW-01 and CIS-FW-02 evidence and closure basis |
| [Evidence index](docs/EVIDENCE_INDEX.md) | Original filename register pending the actual evidence inventory |
| [Evidence instructions](evidence/README.md) | Sanitization and later screenshot publication |

No evidence filenames or screenshots were supplied for this repository update. The index lists the evidence needed and explicitly leaves original filenames pending. Actual sanitized screenshots can later be displayed beneath their matching procedures; no placeholder image files or fabricated output are included.

## Lessons learned and scope limitations

- Verify effective settings and applied GPOs separately; the editor alone does not demonstrate application.
- Narrow pilot targeting supports controlled deployment. This lab does not establish behavior on other servers.
- Reviewing enabled inbound rules helps identify dependencies, but does not replace traffic testing.
- A DomainAuthenticated interface can coexist with validated Public profile configuration; this does not prove Public-profile traffic enforcement was exercised.
- Disabling rule merging does not establish that local rules were deleted or that every security requirement is satisfied.
- Only five firewall checks were reviewed. No CIS-CAT scan, full benchmark score, broader compliance claim, or unperformed remediation is included.
- A previous **Process Creation auditing troubleshooting issue remains unresolved** and outside this firewall scope. Nothing here establishes its remediation.

## Author

**Musah Issah** · Cybersecurity · Information Assurance · Governance, Risk & Compliance

[GitHub](https://github.com/MusahIssah)

*Controlled lab documentation. The proprietary full CIS Benchmark PDF and security-sensitive raw evidence are not published.*
