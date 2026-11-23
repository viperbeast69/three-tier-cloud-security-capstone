# Threat Model

| Threat | Example impact | Preventive / detective controls | Validation evidence |
|---|---|---|---|
| SQL injection | Unauthorized data access or modification | Parameterized queries; least-privilege DB identity; WAF managed rules | Code review and authorized test cases |
| Credential exposure | Database compromise | Secrets Manager; no secrets in Git; task role separation; rotation plan | Secret configuration review; repository secret scan |
| Public database exposure | Direct database attack | Isolated DB subnets; `publicly_accessible = false`; DB security group accepts API SG only | RDS configuration and SG screenshots |
| Web application attacks | XSS, path traversal, common exploit attempts | AWS WAF managed rule groups; response security headers; input validation | WAF metrics and controlled test results |
| Network lateral movement | Compromise spreads between tiers | Separate security groups and subnet tiers; minimum required ports | Security group rule review |
| Privilege escalation | Attacker gains excessive AWS permissions | Separate ECS execution/task roles; scoped permissions; IAM review | IAM policy review |
| Data at rest exposure | Database or logs disclosed | RDS storage encryption and encrypted log groups | AWS configuration screenshots |
| Availability attack | Service exhaustion | WAF rate-based rule; ALB health checks; service desired count | WAF configuration and load/health test |
| Image supply-chain compromise | Vulnerable or malicious container | ECR image scanning; pinned base images; immutable tags in release workflow | ECR scan report and image digest |
| Insufficient monitoring | Delayed incident response | CloudWatch logs; CloudTrail account activity trail recommended | Log events and trail configuration |

## Residual risks

This baseline does not implement a full SIEM, automated incident response, secrets rotation, multi-region disaster recovery, formal vulnerability management, or a complete CI/CD software supply-chain policy. These should be addressed before production use.
