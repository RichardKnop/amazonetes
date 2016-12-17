variable "env" {
  type        = "string"
  description = "Environment name"
}

variable "region" {
  type        = "string"
  description = "AWS region"
}

variable "public_key" {
  type        = "string"
  description = "Public key"
}

variable "vpc_cidr" {
  type        = "string"
  description = "CIDR for VPC"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  type        = "map"
  description = "AWS availability zones"

  default     = {
    zone0 = "ap-southeast-1a"
    zone1 = "ap-southeast-1b"
  }
}

variable "public_cidrs" {
  type        = "map"
  description = "CIDR for public subnet indexed by AZ"

  default     = {
    zone0 = "10.0.0.0/24"
    zone1 = "10.0.10.0/24"
    zone2 = "10.0.20.0/24"
  }
}

variable "private_cidrs" {
  type        = "map"
  description = "CIDR for private subnet indexed by AZ"

  default     = {
    zone0 = "10.0.1.0/24"
    zone1 = "10.0.11.0/24"
    zone2 = "10.0.21.0/24"
  }
}

variable "private_dns_zone_name" {
  type        = "string"
  description = "Amazon Route53 DNS zone name for internal usage"
}

variable "nat_ami" {
  type        = "string"
  description = "AMI for NAT server"
}

variable "nat_instance_type" {
  type        = "string"
  description = "EC2 instance type to use for NAT server"
}
