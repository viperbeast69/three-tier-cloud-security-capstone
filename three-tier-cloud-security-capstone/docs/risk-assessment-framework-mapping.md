# Risk Assessment and Framework Mapping

## 1. Risk method

Use a qualitative 5 × 5 risk matrix. Score likelihood and impact from 1 (Rare/Negligible) to 5 (Almost certain/Critical).

**Risk score = Likelihood × Impact**

| Score | Rating | Treatment |
|---:|---|---|
| 1–4 | Low | Accept with routine monitoring |
| 5–9 | Moderate | Plan and track treatment |
| 10–16 | High | Prioritize remediation and owner approval |
| 17–25 | Critical | Do not go live until treated or formally accepted by accountable leadership |

The ratings below are initial design estimates, not measured findings. Reassess them after deployment and testing.

## 2. Initial risk register

| ID | Threat / risk | Likelihood | Impact | Inherent score | Proposed control / treatment | Residual rating (after validation) |
|---|---|---:|---:|---:|---|---|
| R-01 | SQL injection or unsafe input handling | 3 | 4 | 12 High | Parameterized SQL, input validation, WAF managed rules, secure code review | [Assess] |
| R-02 | Database exposed to the public internet | 2 | 5 | 10 High | Isolated DB subnets, non-public RDS, DB SG accepts only API SG | [Assess] |
| R-03 | Database credential leakage | 3 | 5 | 15 High | Secrets Manager, IAM scoping, secret rotation plan, secret scanning | [Assess] |
| R-04 | Unauthorized access through excessive IAM permissions | 3 | 4 | 12 High | Separate task/execution roles, least privilege, periodic IAM review | [Assess] |
| R-05 | DDoS or application request flooding | 3 | 4 | 12 High | WAF rate-based rule, ALB health checks, scaling and alerting plan | [Assess] |
| R-06 | Vulnerable or compromised container image | 3 | 4 | 12 High | ECR scanning, patched base images, immutable release tags, CI scanning | [Assess] |
| R-07 | Loss of availability from AZ or database failure | 2 | 5 | 10 High | Multi-AZ RDS, multiple tasks, backups, recovery tests (production enhancement) | [Assess] |
| R-08 | Insufficient audit logs delay incident response | 3 | 4 | 12 High | CloudWatch logs, CloudTrail, retention, alerting and review | [Assess] |
| R-09 | Unexpected cloud spend | 3 | 3 | 9 Moderate | Budgets, alerts, cost review, teardown after lab | [Assess] |

## 3. Framework mapping — NIST Cybersecurity Framework 2.0

This is a high-level mapping for educational purposes. It is not a formal audit or certification.

| NIST CSF 2.0 function | Project activities / controls | Evidence to collect |
|---|---|---|
| Govern | Assign application, cloud, security, and management owners; define risk acceptance and cloud cost responsibility | Ownership matrix, approvals, cost budget |
| Identify | Inventory AWS resources, data flows, assets, dependencies, and risks | Architecture diagram, asset list, risk register |
| Protect | IAM least privilege, HTTPS, WAF, segmentation, Secrets Manager, encryption, secure container configuration | IAM policies, listener config, WAF ACL, SG rules, encryption settings |
| Detect | CloudWatch application logs/metrics, CloudTrail account activity, WAF metrics and alarms | Log events, CloudTrail trail, dashboards/alarms |
| Respond | Define triage, containment, credential rotation, escalation, and communications procedures | Incident response runbook and tabletop record |
| Recover | Backups, point-in-time recovery, redeployment from versioned images/IaC, recovery testing | Backup settings, restore test, deployment rollback record |

## 4. Treatment and approval

For every high or critical residual risk, record:
- Risk owner.
- Selected treatment: mitigate, avoid, transfer, or accept.
- Remediation action and due date.
- Evidence that the control works.
- Formal risk acceptance if the risk remains.

No risk should be marked closed merely because a control is planned. Close it only after implementation and validation evidence are recorded.
