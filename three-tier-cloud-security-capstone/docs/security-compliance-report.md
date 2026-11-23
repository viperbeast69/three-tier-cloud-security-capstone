# Security and Compliance Readiness Report

**Project:** Three-Tier Cloud Application  
**Platform:** Amazon Web Services (AWS)  
**Status:** Design and implementation package — deployment evidence pending  
**Prepared by:** [Your name]  
**Date:** [Insert date]

## 1. Executive summary

This project proposes a segmented three-tier AWS architecture for a web application. The design places the public entry point behind AWS WAF and an HTTPS Application Load Balancer, hosts frontend and API containers in private application subnets, and stores application data in a non-public Amazon RDS PostgreSQL database.

The architecture applies defense in depth through network segmentation, restrictive security groups, IAM role separation, managed secret delivery, encryption at rest, and centralized application logging.

**Go-live decision:** Do not approve production go-live based on this template alone. Approval requires completion of the validation checklist, review of actual AWS configuration, resolution of findings, and sign-off by the responsible security, application, and operations owners.

## 2. Scope

In scope:
- AWS VPC and subnet architecture.
- Load balancing and web application firewall.
- Frontend and API container services.
- RDS PostgreSQL data tier.
- IAM, Secrets Manager, encryption, and CloudWatch logging.

Out of scope unless separately implemented:
- Full enterprise identity federation and MFA rollout.
- SIEM integration and 24/7 SOC operations.
- Formal penetration test and independent audit.
- Multi-region disaster recovery.
- Regulatory certification.

## 3. Security controls

| Control area | Design control | Evidence to attach |
|---|---|---|
| Network security | Public ALB; private ECS tasks; isolated RDS subnets; tier-specific SGs | VPC, subnet and SG screenshots |
| Transport security | HTTPS listener; HTTP-to-HTTPS redirect | ALB listener and certificate screenshots |
| Web protection | AWS WAF managed rule groups and rate-based rule | WAF ACL configuration and metrics |
| Identity and access | Separate ECS task execution and task roles; least privilege review | IAM role and policy screenshots |
| Secrets | Database password stored in Secrets Manager and injected into API task | Secret metadata and task definition (redact values) |
| Data protection | RDS storage encryption and encrypted CloudWatch log groups | RDS and log group configuration |
| Monitoring | Application logs in CloudWatch; CloudTrail recommended for account activity | Log events and CloudTrail status |
| Container security | ECR image scanning; release images should use immutable tags | ECR scan findings and image digest |

## 4. Threats and mitigations

See [Threat Model](threat-model.md). Risks include injection, credential exposure, public database exposure, web exploits, lateral movement, privilege escalation, data disclosure, denial of service, vulnerable images, and insufficient monitoring.

## 5. Risk assessment and framework mapping

See [Risk Assessment and Framework Mapping](risk-assessment-framework-mapping.md) for the initial risk register, scoring method, treatments, and NIST CSF 2.0 mapping. Re-score risks after controls are deployed and tested.

## 6. Cost management

See [Cloud Concepts and Design](cloud-concepts-and-design.md) for the resource-level cost table. Complete the estimate using AWS Pricing Calculator for the selected region, resource sizes, runtime, and expected traffic. Record actual lab spend from AWS billing/Cost Explorer. The design includes chargeable services such as ALB, NAT Gateway, Fargate, RDS, WAF, CloudWatch, ECR, and data transfer. Set a budget alert and destroy lab resources when finished.

## 7. Compliance considerations

The controls are mapped at a high level to common security principles found in frameworks such as:
- **CIS AWS Foundations Benchmark:** identity/access management, logging, networking, and monitoring.
- **NIST Cybersecurity Framework:** Identify, Protect, Detect, Respond, Recover.
- **ISO/IEC 27001:** risk-based information security controls and documented operational processes.

This is an educational control alignment, **not** a formal compliance assessment, certification, or claim of compliance. Applicability depends on the organization's scope, jurisdiction, data types, and contractual obligations.

## 8. Validation results

Complete this section only after running the checks. Do not mark a control as passed without evidence.

| Test | Expected result | Actual result | Status / evidence |
|---|---|---|---|
| HTTPS access | Valid certificate and secure connection | [Record] | [Pending] |
| HTTP redirect | HTTP redirects to HTTPS | [Record] | [Pending] |
| WAF enabled | Web ACL associated with ALB | [Record] | [Pending] |
| Frontend reachability | Public access only through ALB | [Record] | [Pending] |
| API routing | `/api/health` returns HTTP 200 | [Record] | [Pending] |
| Database isolation | RDS has no public endpoint access | [Record] | [Pending] |
| DB connectivity | API can connect; internet cannot directly connect | [Record] | [Pending] |
| Encryption | RDS and log groups encrypted | [Record] | [Pending] |
| Logging | Application logs visible in CloudWatch | [Record] | [Pending] |
| IAM review | No broad wildcard permissions beyond justified service needs | [Record] | [Pending] |

## 9. Findings and remediation

| ID | Finding | Severity | Remediation | Owner | Due date |
|---|---|---|---|---|---|
| F-01 | Deployment evidence not yet attached | Medium | Deploy and complete validation checklist | [Owner] | [Date] |
| F-02 | Production resilience not fully configured | Medium | Add Multi-AZ database, backup and recovery tests | [Owner] | [Date] |
| F-03 | CI/CD security pipeline not included | Medium | Add build, scan, signing and deployment controls | [Owner] | [Date] |

Update severities after actual testing and risk assessment.

## 10. Go-live recommendation

**Current recommendation: Conditional / Not yet approved.** The architecture provides a reasonable security baseline for a lab demonstration, but production approval must wait until:
1. Deployment and all validation checks are complete.
2. High and critical findings are remediated or formally accepted.
3. IAM, WAF, encryption, logging, backup, and recovery settings are reviewed.
4. Operations ownership, alerting, incident response, and rollback procedures are documented.
5. Security and business owners provide written approval.

## 11. Sign-off

| Role | Name | Decision | Date |
|---|---|---|---|
| Application owner | [Name] | [Pending] | [Date] |
| Cloud / operations owner | [Name] | [Pending] | [Date] |
| Security reviewer | [Name] | [Pending] | [Date] |
| Management approver | [Name] | [Pending] | [Date] |
