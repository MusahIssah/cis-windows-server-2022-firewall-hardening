# Selected Firewall Assessment Report

[Overview](../README.md) · [Findings](FINDINGS.md) · [Evidence index](EVIDENCE_INDEX.md)

## Executive assessment

Five selected CIS firewall checks were reviewed on SRV01, a Windows Server 2022 member server managed through DC01 Active Directory and Group Policy. All three firewall profile enablement checks passed. Two Public profile rule-merging checks initially failed and were remediated through a narrowly scoped GPO. Final effective values met the five selected targets.

This is an author-reported **effective-configuration validation**, not an official CIS-CAT assessment, complete benchmark evaluation, or compliance certification. No assessment date, scan artifact, screenshot filename, or generated script report was supplied.

## Scope and criteria

| Item | Scope |
| --- | --- |
| Target | SRV01, Windows Server 2022 member server |
| Management | DC01, Active Directory, Group Policy |
| Reference | CIS Microsoft Windows Server 2022 Benchmark v5.1.0, Level 1 Member Server |
| Selected checks | 9.1.1, 9.2.1, 9.3.1, 9.3.4, 9.3.5 |
| Evidence basis | Supplied before/after configuration observations and applied-GPO verification |
| Exclusions | Full CIS benchmark, CIS-CAT scanning, traffic testing, Process Creation auditing remediation |

## Assessment and implementation

The pre-deployment review inspected locally enabled inbound rules and verified Ethernet was DomainAuthenticated. Individual rule details and a connectivity test outcome were not supplied.

The administrator created **CIS-SRV01-Public-Firewall-Hardening**, linked it to **Pilot OU**, and scoped it to the **SRV01 computer account**. The two Public profile rule-merging options were set to **No**, preserving Domain and Private profile settings. Exact security-filtering mechanics, policy refresh commands, and deployment timestamps are not inferred.

## Results

| Check | Before | After | Outcome |
| --- | --- | --- | --- |
| 9.1.1 Domain Firewall Enabled | True — Pass | True — Pass | Preserved |
| 9.2.1 Private Firewall Enabled | True — Pass | True — Pass | Preserved |
| 9.3.1 Public Firewall Enabled | True — Pass | True — Pass | Preserved |
| 9.3.4 Public Apply local firewall rules | True — Fail | False — Pass | CIS-FW-01 remediated at effective-configuration level |
| 9.3.5 Public Apply local connection security rules | True — Fail | False — Pass | CIS-FW-02 remediated at effective-configuration level |

## Independent change validation

`Get-NetFirewallProfile -PolicyStore ActiveStore` verified final Public values: Enabled True, AllowLocalFirewallRules False, AllowLocalIPsecRules False. `gpresult /r /scope computer` confirmed **CIS-SRV01-Public-Firewall-Hardening** in the applied GPO list.

These checks establish the recorded effective settings and GPO application. They do not independently establish a complete policy precedence analysis, deletion of local rules, Public-category packet behavior, or sustained compliance after future changes.

## Residual limitations and evidence availability

Only the five named checks were assessed; no broader CIS score is reported. Sanitized original evidence is pending publication, so readers cannot yet inspect the underlying captures. The [evidence index](EVIDENCE_INDEX.md) records missing filenames without inventing them.

The prior Process Creation auditing troubleshooting issue remains **unresolved and outside scope**. The read-only collector was authored for repeat verification; no new execution on SRV01 or report output is claimed. Future changes should be revalidated and documented separately rather than treated as completed here.
