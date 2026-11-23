# Cloud Computing Concepts and Architecture Design

## 1. Real-world use case

A small-to-medium organization needs to host a customer-facing web application with a browser-based frontend, REST API, and relational database. The solution must support secure internet access, controlled internal communication, monitoring, auditability, and cost-conscious operation.

## 2. Cloud computing concepts

Cloud computing provides on-demand access to configurable computing resources over a network. The organization benefits from:
- **On-demand self-service:** infrastructure can be provisioned through Terraform when required.
- **Broad network access:** users reach the application through a public HTTPS endpoint.
- **Resource pooling:** AWS supplies shared underlying infrastructure while the organization receives logically isolated resources.
- **Rapid elasticity:** ECS services can be scaled by changing desired task counts and adding autoscaling policies.
- **Measured service:** AWS usage is metered and can be reviewed through billing and cost-management tools.

## 3. Service model

| Model | Meaning | Application in this solution |
|---|---|---|
| IaaS | Customer manages operating systems and application stack on virtualized compute/network/storage | VPC, subnets, routing, security groups, and underlying AWS networking |
| PaaS / managed platform | Provider manages more of the runtime/platform | Amazon RDS manages the PostgreSQL database service; ECS Fargate manages container compute infrastructure |
| SaaS | Complete software delivered to end users | Not the primary model for this custom application; the finished web application is consumed by end users |

This design is a **mixed service-model architecture**: infrastructure networking is configured by the project team, while managed services reduce operational overhead for containers, database operations, secrets, logging, and web filtering.

## 4. Deployment model

The proposed environment is a **public-cloud deployment** hosted in the AWS account. Workload components are logically isolated in a dedicated VPC. The application is intended for public customers, while application tasks and the database remain on private network segments.

A private cloud or hybrid deployment is not required by the stated scenario. If organizational policy later requires on-premises integration, a hybrid model could be considered using a private network connection and additional identity/network controls.

## 5. Architecture choices

- **Virtualization / compute:** ECS on AWS Fargate runs containerized frontend and API workloads without the project team managing EC2 host operating systems. Fargate abstracts the server fleet; containers provide application-level packaging and isolation.
- **Storage:** Amazon RDS PostgreSQL provides relational storage with encrypted storage and automated backups. CloudWatch log groups retain application logs. ECR stores container images.
- **Networking:** a VPC is divided into public, private application, and isolated database subnets across two Availability Zones. The public ALB receives web traffic. Private application tasks receive traffic from the ALB. The database accepts PostgreSQL only from the application security group.
- **Scalability:** ALB distributes incoming requests across healthy tasks. ECS desired task count can be increased, and production deployment should add CPU/memory-based service autoscaling. RDS can be resized and upgraded; production should assess Multi-AZ and read replicas based on availability and read-load requirements.
- **Security:** AWS WAF, HTTPS, restrictive security groups, IAM roles, Secrets Manager, encryption, and CloudWatch logging provide layered controls.

## 6. Availability and scalability limitations

The educational Terraform configuration uses one NAT Gateway, one task per service, and a single-AZ RDS instance to reduce complexity and cost. Although the ALB and subnets span two Availability Zones, this alone does not make the complete solution highly available. Production readiness requires Multi-AZ RDS, multiple tasks per service, ECS autoscaling, resilient egress, tested backups, and a recovery plan.

## 7. Cost management

The deployment can incur charges for the ALB, NAT Gateway and data processing, Fargate task runtime, RDS instance and storage, WAF requests, CloudWatch ingestion/retention, ECR storage, and data transfer.

Cost-control actions:
1. Use a short lab window and destroy resources when testing is complete.
2. Select the smallest supported task and database sizes for a demonstration.
3. Set AWS Budgets alerts before deployment.
4. Review Cost Explorer and service-level usage after testing.
5. Set CloudWatch log retention appropriate to the lab.
6. Avoid leaving NAT Gateway, ALB, RDS, or Fargate resources running when unused.
7. Estimate costs with AWS Pricing Calculator using the selected region and expected hours/traffic; record the estimate and actual spend in the report.

**Cost estimate to complete before submission**

| Resource | Region / size | Estimated monthly cost | Actual lab cost |
|---|---|---:|---:|
| Application Load Balancer | [Fill in] | [Fill in] | [Fill in] |
| NAT Gateway + data processing | [Fill in] | [Fill in] | [Fill in] |
| ECS Fargate frontend/API | [Fill in] | [Fill in] | [Fill in] |
| RDS PostgreSQL | [Fill in] | [Fill in] | [Fill in] |
| AWS WAF | [Fill in] | [Fill in] | [Fill in] |
| CloudWatch / ECR / data transfer | [Fill in] | [Fill in] | [Fill in] |
| **Total** | | **[Calculate]** | **[Calculate]** |

Do not invent cost figures: calculate them for the selected AWS region, resource sizes, hours, and traffic.
