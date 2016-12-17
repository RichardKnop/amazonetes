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
  description = "CoreOS AMI for instances"
}

variable "deployer_key_name" {
  type        = "string"
  description = "Deployer key pair name"
}

variable "default_security_group_id" {
  type        = "string"
  description = "Default security group ID"
}

variable "etcd_client_security_group_id" {
  type        = "string"
  description = "Security group which allows connection to etcd cluster"
}

variable "master_common_name" {
  type        = "string"
  description = "Master node common name"
}

variable "master_hostname" {
  type        = "string"
  description = "Master node hostname"
}

variable "master_instance_type" {
  type        = "string"
  description = "EC2 instance type to use for master node"
}

variable "master_private_ip" {
  type        = "string"
  description = "Private IP address to use for master node"
}

variable "etcd_endpoints" {
  type        = "string"
  description = "List of etcd machines (http://ip:port), comma separated. If you're running a cluster of 5 machines, list them all here."
}

variable "worker_common_names" {
  type        = "list"
  description = "List of worker node common names (e.g. worker0)"
}

variable "worker_hostnames" {
  type        = "list"
  description = "List of worker node hostnames (e.g. worker0.stage-worker)"
}

variable "worker_instance_type" {
  type        = "string"
  description = "EC2 instance type to use for worker nodes"
}

variable "worker_private_ip_from" {
  type        = "string"
  description = "Worker private IPs will start from 10.X.X.worker_private_ip_from"
}

variable "kubernetes_version" {
  type        = "string"
  description = "Kubernetes version to deploy"
  default     = "v1.5.1_coreos.0"
}

variable "pod_network" {
  type        = "string"
  description = "The CIDR network to use for pod IPs. Each pod launched in the cluster will be assigned an IP out of this range. This network must be routable between all hosts in the cluster. In a default installation, the flannel overlay network will provide routing to this network."
  default     = "10.2.0.0/16"
}

variable "service_ip_range" {
  type        = "string"
  description = "The CIDR network to use for service cluster VIPs (Virtual IPs). Each service will be assigned a cluster IP out of this range. This must not overlap with any IP ranges assigned to the pod_network, or other existing network infrastructure. Routing to these VIPs is handled by a local kube-proxy service to each host, and are not required to be routable between hosts."
  default     = "10.3.0.0/24"
}

variable "kubernetes_service_ip" {
  type        = "string"
  description = "The VIP (Virtual IP) address of the Kubernetes API Service. If the service_ip_range is changed above, this must be set to the first IP in that range."
  default     = "10.3.0.1"
}

variable "dns_service_ip" {
  type        = "string"
  description = "The VIP (Virtual IP) address of the cluster DNS service. This IP must be in the range of the service_ip_range and cannot be the first IP in the range. This same IP must be configured on all worker nodes to enable DNS service discovery."
  default     = "10.3.0.10"
}

variable "force_destroy" {
  type        = "string"
  description = "Delete S3 buckets content"
}
