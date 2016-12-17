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

variable "private_subnet_cidrs" {
  type        = "list"
  description = "Private subnet CIDR blocks"
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

variable "cluster_id" {
  type        = "string"
  description = "Unique name for the cluster"
}

variable "etcd_common_names" {
  type        = "list"
  description = "List of etcd node common names (e.g. etcd0)"
}

variable "etcd_hostnames" {
  type        = "list"
  description = "List of etcd node hostnames (e.g. etcd0.stage-etcd)"
}

variable "etcd_instance_type" {
  type        = "string"
  description = "EC2 instance type to use for cluster nodes"
}

variable "etcd_private_ip_from" {
  type        = "string"
  description = "ETCD nodes private IPs will start from 10.X.X.etcd_private_ip_from"
}

variable "force_destroy" {
  type        = "string"
  description = "Delete S3 buckets content"
}
