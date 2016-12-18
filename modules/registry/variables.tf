variable "env" {
  type        = "string"
  description = "Environment name"
}

variable "region" {
  type        = "string"
  description = "AWS region"
}

variable "vpc_id" {
  type        = "string"
  description = "VPC ID"
}

variable "private_subnet_ids" {
  type        = "list"
  description = "Private subnet IDs"
}

variable "private_dns_zone_id" {
  type        = "string"
  description = "Amazon Route53 DNS zone identifier"
}

variable "private_dns_zone_name" {
  type        = "string"
  description = "Amazon Route53 DNS zone name"
}

variable "ca_key_algorithm" {
  type        = "string"
  description = "CA private key algorithm"
}

variable "ca_private_key_pem" {
  type        = "string"
  description = "CA private key in PEM format"
}

variable "ca_cert_pem" {
  type        = "string"
  description = "CA certificate in PEM format"
}

variable "coreos_ami" {
  type        = "string"
  description = "CoreOS AMI for ETCD instances"
}

variable "deployer_key_name" {
  type        = "string"
  description = "Deployer key pair name"
}

variable "default_security_group_id" {
  type        = "string"
  description = "Default security group ID"
}

variable "user_security_group_ids" {
  type        = "list"
  description = "Security group IDs that will be able to connect to the registry"
}

variable "registry_instance_type" {
  type        = "string"
  description = "EC2 instance type to use for docker registry"
}

variable "registry_subnet_cidr" {
  type        = "string"
  description = "Subnet CIDR for private docker registry"
}

variable "registry_hostnum" {
  type        = "string"
  description = "Given an IP address range in CIDR notation, this host number will be used to define IP address."
}

variable "registry_port" {
  type        = "string"
  description = "Registry port"
}

variable "force_destroy" {
  type        = "string"
  description = "Delete S3 buckets content"
}
