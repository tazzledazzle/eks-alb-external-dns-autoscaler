variable "cluster_name" { 
  description = "The name of the EKS cluster"
  type = string
  default = "demo-eks"
  validation {
    condition = length(var.cluster_name) > 2 && length(var.cluster_name) < 20
    error_message = "Cluster name must be between 3 and 20 characters."
  }
}
variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.30"
}
variable "aws_region" { 
  type = string
  default = "us-west-2"
}

variable "vpc_cidr" {
    description = "VPC CIDR block"
    type = string
    default = "10.0.0.0/16"
    validation {
      condition     = can(cidrhost(var.vpc_cidr, 0))
      error_message = "Must be a valid CIDR."
    }
}
variable "public_subnets" {
    type = list(string)
    default = ["10.0.1.0/24","10.0.2.0/24"]
}
variable "private_subnets" {
    type = list(string)
    default = ["10.0.3.0/24","10.0.4.0/24"]
}

variable "domain_filter" {           # Route 53 zone that external‑dns may manage
  type    = string
  default = "example.com"
}
