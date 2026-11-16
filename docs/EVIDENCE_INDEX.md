# Evidence Index and Publication Record

[Inline evidence walkthrough](../README.md#evidence-walkthrough) · [Publication instructions](../evidence/README.md)

Five real screenshots and four reviewed text artifacts are published. All images were cropped on copies; the scope image also uses opaque redaction. Source files remain unchanged outside the repository. No AI image generation or reconstruction was used.

| Reference | Original evidence filename | Public artifact | Interpretation / treatment |
| --- | --- | --- | --- |
| E01 | `08_CIS_Active_Network_Profile.txt` | [Network category](../evidence/08_CIS_Active_Network_Profile.txt) | Ethernet DomainAuthenticated; text encoding/whitespace normalized |
| E02 | `02_CIS_Firewall_State_Verified.png` | [Baseline screenshot](../evidence/02_CIS_Firewall_State_Verified.png) | All profiles enabled; cropped to console |
| E02 | `03_CIS_Firewall_Policy_Assessment.txt` | [Effective before-state](../evidence/03_CIS_Firewall_Policy_Assessment.txt) | Public merging True/True; reviewed text, encoding/whitespace normalized |
| E03 | `CIS-SRV01-Public-Firewall-Hardening.png` | [New GPO dialog](../evidence/CIS-SRV01-Public-Firewall-Hardening.png) | Name entry only; cropped dialog, not standalone proof of application |
| E03 | `07_CIS_Firewall_GPO_Linked_and_Scoped.png` | [Pilot link and scope](../evidence/07_CIS_Firewall_GPO_Linked_and_Scoped.png) | Pilot and SRV01 retained; domain/path/namespace redacted; unrelated GPO tree cropped out |
| E04 | `05_CIS_Firewall_GPO_Created.png` | [Editor before configuration](../evidence/05_CIS_Public_Rule_Merging_Before.png) | Renamed to match visible content: both options Not configured; cropped |
| E04 | `06_CIS_Public_Firewall_Settings_Configured.png` | [Editor after configuration](../evidence/06_CIS_Public_Firewall_Settings_Configured.png) | Both options No; cropped dialog |
| E05 | `09_CIS_Firewall_Remediation_Validation.txt` | [Final effective Public values](../evidence/09_CIS_Firewall_Remediation_Validation.txt) | Enabled True, merging False/False; text encoding/whitespace normalized |
| E05 | `10_CIS_GPO_Application_Verification.txt` | [Sanitized applied-GPO excerpt](../evidence/10_CIS_GPO_Application_Verification_Excerpt.txt) | Only the relevant applied GPO entry retained; full raw output withheld |
| E06 | `CIS_Windows_Server_2022_Firewall_Assessment_Report.md` | Preservation documented in [assessment report](ASSESSMENT_REPORT.md) | Source narrative supports preserved Domain/Private settings; no separate post-change profile screenshot supplied |

## Private or excluded source material

- `01_CIS_Firewall_Baseline.txt`: its Enable column is blank, so it is not used as proof of firewall enablement. The actual state screenshot provides that evidence.
- `04_CIS_GPO_Baseline.txt` and the full `10_CIS_GPO_Application_Verification.txt`: raw domain, topology, and unrelated GPO details remain private.
- `07_CIS_Local_Firewall_Rule_Impact_Check.txt`: detailed rule inventory reviewed privately; publication records the review without exposing the inventory.
- `# CIS Windows Server 2022 — Securit.txt` and the source assessment narrative: relevant supplied conclusions are represented in the curated report and findings rather than uploaded as duplicate records.

All nine public artifacts are displayed directly in the README. No final-output screenshot, traffic test, new collector execution, official CIS-CAT result, or Process Creation auditing resolution is invented. Continue sanitizing new evidence before publication; retain exact original-to-public filename mappings.
