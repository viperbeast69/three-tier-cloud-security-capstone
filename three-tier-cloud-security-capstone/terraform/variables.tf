variable "aws_region" {
  description = "AWS region for the deployment."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Short lowercase project identifier."
  type        = string
  default     = "three-tier-capstone"
}

variable "domain_name" {
  description = "Public DNS name covered by the ACM certificate."
  type        = string
}

variable "certificate_arn" {
  description = "ACM certificate ARN in the selected AWS region."
  type        = string
}

variable "container_tag" {
  description = "Container image tag to deploy."
  type        = string
  default     = "latest"
}

variable "db_username" {
  description = "Application database username."
  type        = string
  default     = "appuser"
}

variable "db_password" {
  description = "Database password. Supply via TF_VAR_db_password or a secure CI secret; never commit it."
  type        = string
  sensitive   = true
}

variable "allowed_admin_cidr" {
  description = "Reserved for optional administrative access; no direct admin ingress is opened by this baseline."
  type        = string
  default     = "0.0.0.0/32"
}

variable "deploy_services" {
  description = "Set true only after both container images have been pushed to ECR."
  type        = bool
  default     = false
}
