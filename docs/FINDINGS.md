# Firewall Finding Records

[Overview](../README.md) · [Assessment report](ASSESSMENT_REPORT.md) · [Evidence index](EVIDENCE_INDEX.md)

Findings are grounded in supplied observations. Original filenames and sanitized captures remain pending. No severity score, exploitation, malicious rule, or incident is inferred.

## CIS-FW-01 — Public local firewall rule merging enabled

| Field | Record |
| --- | --- |
| Target / criterion | SRV01; selected CIS 9.3.4, Level 1 Member Server, benchmark v5.1.0 |
| Before | Public AllowLocalFirewallRules True — Fail |
| Impact | Local firewall rules could merge with the Public profile's centrally managed policy, weakening centralized control over the effective rule set |
| Remediation performed | Set Public Apply local firewall rules to No through CIS-SRV01-Public-Firewall-Hardening; linked to Pilot OU and scoped to SRV01 |
| After | Public AllowLocalFirewallRules False — Pass; Public Enabled True |
| Verification | ActiveStore profile query and applied GPO list from computer-scope gpresult |
| Status | **Remediated at effective-configuration level** |
| Evidence references | E02, E04, E05 in the index; original filenames pending |

**Closure basis:** the supplied final effective value is False, and the applied GPO list contains the named hardening GPO. This establishes configuration remediation only. It does not demonstrate traffic testing, deletion of local rules, or that a malicious rule ever existed. Domain and Private settings were preserved.

## CIS-FW-02 — Public local connection security rule merging enabled

| Field | Record |
| --- | --- |
| Target / criterion | SRV01; selected CIS 9.3.5, Level 1 Member Server, benchmark v5.1.0 |
| Before | Public AllowLocalIPsecRules True — Fail |
| Impact | Local connection security rules could merge with the Public profile's centrally managed settings, reducing central control over connection security requirements |
| Remediation performed | Set Public Apply local connection security rules to No in the same targeted hardening GPO |
| After | Public AllowLocalIPsecRules False — Pass; Public Enabled True |
| Verification | ActiveStore profile query and applied GPO list from computer-scope gpresult |
| Status | **Remediated at effective-configuration level** |
| Evidence references | E02, E04, E05 in the index; original filenames pending |

**Closure basis:** the supplied final effective value is False, and the named GPO is listed as applied. No IPsec negotiation test, traffic behavior, rule deletion, or enterprise-wide deployment is claimed. Domain and Private settings were preserved.

## Scope boundary

These records are selected effective-configuration validations, not official CIS-CAT findings or a full compliance assessment. The previous Process Creation auditing troubleshooting issue remains unresolved; it is not closed by either firewall finding.
