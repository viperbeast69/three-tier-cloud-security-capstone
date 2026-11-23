# Deployment and Security Validation Checklist

Record the date, command, result, and screenshot or log for each test.

## Infrastructure

- [ ] `terraform fmt -check -recursive`
- [ ] `terraform validate`
- [ ] `terraform plan` reviewed before apply
- [ ] VPC contains intended public, private application, and database subnets
- [ ] ECS tasks have no public IP
- [ ] RDS is not publicly accessible
- [ ] RDS security group permits TCP 5432 only from API task security group
- [ ] ALB security group accepts inbound 80/443 only from intended sources

## Application

- [ ] Frontend loads through ALB hostname/domain
- [ ] `https://YOUR_DOMAIN/api/health` returns HTTP 200
- [ ] API database check succeeds after database configuration
- [ ] Unavailable database returns a generic error without leaking secrets
- [ ] Container processes run as non-root where configured

## Security

- [ ] ACM certificate is valid and attached to HTTPS listener
- [ ] HTTP redirects to HTTPS
- [ ] AWS WAF Web ACL is associated with ALB
- [ ] WAF managed rules and rate-based rule are enabled
- [ ] RDS storage encryption is enabled
- [ ] CloudWatch log group encryption is enabled
- [ ] Database credentials are not present in Git, source code, or task definition plaintext
- [ ] IAM policies reviewed for least privilege
- [ ] ECR image scan findings reviewed and remediated
- [ ] CloudTrail is enabled for account activity logging

## Evidence to capture

Save genuine screenshots (redact account IDs, public IPs if sensitive, hostnames if required, and all secret values) under `evidence/`:
1. VPC and subnet layout.
2. ALB listeners and target health.
3. WAF association and rules.
4. ECS services and task placement.
5. RDS connectivity and encryption settings.
6. Security group inbound rules.
7. Secrets Manager secret metadata (never reveal secret value).
8. CloudWatch logs.
9. Browser showing HTTPS frontend and API health response.
10. Terraform validation output.

Do not fabricate screenshots or test results.
