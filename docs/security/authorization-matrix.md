# Authorization Matrix

Legend: `C` create, `R` read, `U` update, `X` execute/action, `A` administer, `own` means only the actor-owned resource, `pub` public projection, `asg` assigned resources.

| Resource/action | Anonymous | Verified lead | Client user (V1) | Sales | Support | Knowledge editor | Admin/Owner |
|---|---|---|---|---|---|---|---|
| public conversation | CRU own | CRU own/linked | CRU own | R/U assigned | R/U support assigned | no default | A tenant |
| private conversation | — | — | R own/account allowed | R assigned commercial | R assigned support | — | R/A audited |
| briefing/opportunity map | CRU own | CRU own | R own if shared | CRU assigned | R when handoff | — | A |
| lead/contact/company | — until consent/verification | R/U limited own | R own profile only | CRU assigned | R only support need | — | A |
| qualification | R explanation own | R own | — | R/U human override reason | R support context only | — | A/config |
| meeting slots | R public | R/X own | R/X own | CRU assigned | R | — | A |
| meeting record | — | R own | R own | R/U assigned | R if support relevant | — | A |
| public knowledge | R pub | R pub | R pub | R | R | CRU drafts/publish by workflow | A |
| private/client knowledge | — | — | R authorized account/project | R if assigned/policy | R assigned | CRU authorized scope | A audited |
| support request MVP | C/R ref own | C/R own | C/R own | R assigned if routed | CRU assigned | — | A |
| ticket/project/client | — | — | R/U limited authorized | R assigned | CRU assigned | — | A audited |
| attachment V1 | — | C/R own purpose | C/R own authorized | R assigned | R assigned | C/R source docs | A audited |
| prompt/agent version | — | — | — | R published metadata only | R published metadata only | R/draft role if granted | A/publish with eval |
| tools | allowlisted public/own | allowlisted own | allowlisted resource | assigned capability | assigned capability | knowledge-only | policy/admin, no bypass |
| integrations/credentials | — | — | — | health only | health only | — | config; secret value never read back |
| analytics | — | — | own service status only | commercial aggregates | support aggregates | knowledge quality | tenant aggregates |
| audit log | — | — | own access summary by privacy process | limited relevant | limited relevant | publish actions | restricted Admin/Owner/security |
| flags/settings/users/roles | — | — | — | — | — | — | A; owner-only for security roles |

Every permission is also constrained by tenant, resource relationship, current state, feature flag, consent/purpose, risk and confirmation. UI visibility is not authorization. Unauthorized and non-existent private resources use an enumeration-safe response.
