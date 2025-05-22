variable "cluster_name" { type = string  default = "demo-eks" }
variable "aws_region"   { type = string  default = "us-west-2" }

variable "vpc_cidr"     { type = string  default = "10.0.0.0/16" }
variable "public_subnets"  { type = list(string) default = ["10.0.1.0/24","10.0.2.0/24"] }
variable "private_subnets" { type = list(string) default = ["10.0.3.0/24","10.0.4.0/24"] }

variable "domain_filter" {           # Route 53 zone that external‑dns may manage
  type    = string
  default = "example.com"
}