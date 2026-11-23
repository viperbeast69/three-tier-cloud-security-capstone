# Architecture and Design Rationale

## Overview

The workload is separated into presentation, application/API, and data tiers. AWS WAF filters common web threats before requests reach an internet-facing Application Load Balancer (ALB). The ALB forwards normal requests to the frontend ECS service and `/api/*` requests to the API ECS service.

## Network design

- One dedicated VPC with public, private application, and isolated database subnets in two Availability Zones.
- Public subnets contain the ALB and NAT Gateway.
- ECS tasks run in private application subnets and do not receive public IP addresses.
- RDS runs in isolated database subnets and is configured as non-public.
- Security groups enforce ALB → frontend/API and API → database communication only.

## Data flow

1. A user resolves the application hostname and connects over HTTPS.
2. AWS WAF evaluates the request using AWS managed rule groups.
3. The ALB routes `/api/*` to the API target group; other paths go to the frontend target group.
4. The API retrieves its database credential from Secrets Manager through ECS task secret injection.
5. The API connects to PostgreSQL on TCP 5432.
6. Application and infrastructure logs are sent to CloudWatch.

## Availability and recovery

The example spans two Availability Zones for the load balancer and ECS placement, but uses a single-AZ RDS instance and one NAT Gateway to control educational lab cost. This is not a production high-availability design. Production should use Multi-AZ RDS, tested backups and point-in-time recovery, multi-AZ egress, autoscaling, and documented recovery objectives.

## Assumptions and limitations

- A valid ACM certificate ARN and DNS hostname must be supplied.
- Container images must be pushed to the ECR repositories created by Terraform before ECS tasks can become healthy.
- The supplied demo API has a database connectivity check, not a full business application.
- The Terraform configuration is a teaching baseline and requires review, testing, and environment-specific hardening before production use.
