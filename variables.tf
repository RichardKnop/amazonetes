variable "env" {
  type        = "string"
  description = "Environment name"
}

variable "region" {
  type        = "string"
  description = "AWS region"
  default     = "ap-southeast-1"
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

variable "public_key" {
  type        = "string"
  description = "Public key"
}

variable "nat_ami" {
  type        = "string"
  description = "AMI for NAT server"
  default     = "ami-a79b49c4"
}

variable "coreos_ami" {
  type        = "string"
  description = "CoreOS AMI"
  default     = "ami-0a842869"
}

variable "private_dns_zone_name" {
  type        = "string"
  description = "Amazon Route53 DNS zone name for internal usage"
  default     = "local"
}

variable "nat_instance_type" {
  type        = "string"
  description = "EC2 instance type to use for NAT server"
  default     = "t2.micro"
}

variable "etcd_instance_type" {
  type        = "string"
  description = "EC2 instance type to use for ETCD nodes"
  default     = "t2.micro"
}

variable "registry_instance_type" {
  type        = "string"
  description = "Docker registry instance type"
  default     = "t2.small"
}

variable "registry_port" {
  type        = "string"
  description = "Docker registry port"
  default     = "443"
}

variable "master_instance_type" {
  type        = "string"
  description = "EC2 instance type to use for master node"
  default     = "t2.small"
}

variable "worker_instance_type" {
  type        = "string"
  description = "EC2 instance type to use for worker nodes"
  default     = "t2.small"
}

variable "worker_cluster_size" {
  type        = "string"
  description = "Worker pool cluster size (number of nodes)"
  default     = 2
}

variable "force_destroy" {
  type        = "string"
  description = "Delete S3 buckets content"
  default     = false
}
