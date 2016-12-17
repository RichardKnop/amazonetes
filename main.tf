module "ca" {
  source = "./modules/ca"
}

module "vpc" {
  source = "./modules/vpc"

  env = "${var.env}"
  region = "${var.region}"
  public_key = "${var.public_key}"

  vpc_cidr = "${var.vpc_cidr}"
  availability_zones = "${var.availability_zones}"
  public_cidrs = "${var.public_cidrs}"
  private_cidrs = "${var.private_cidrs}"
  private_dns_zone_name = "${var.private_dns_zone_name}"

  nat_ami = "${var.nat_ami}"
  nat_instance_type = "${var.nat_instance_type}"
}

module "etcd" {
  source = "./modules/etcd"

  env = "${var.env}"
  region = "${var.region}"
  vpc_id = "${module.vpc.vpc_id}"

  private_subnet_ids = "${module.vpc.private_subnet_ids}"
  private_subnet_cidrs = "${module.vpc.private_subnet_cidrs}"
  private_dns_zone_id = "${module.vpc.private_dns_zone_id}"
  private_dns_zone_name = "${var.private_dns_zone_name}"

  ca_key_algorithm = "${module.ca.ca_key_algorithm}"
  ca_private_key_pem = "${module.ca.ca_private_key_pem}"
  ca_cert_pem = "${module.ca.ca_cert_pem}"

  coreos_ami = "${var.coreos_ami}"
  deployer_key_name = "${module.vpc.deployer_key_name}"
  default_security_group_id = "${module.vpc.default_security_group_id}"

  cluster_id = "${var.env}-etcd"
  etcd_common_names = [
    "etcd0",
    "etcd1",
  ]
  etcd_hostnames = [
    "etcd0.${var.env}-etcd",
    "etcd1.${var.env}-etcd",
  ]
  etcd_instance_type = "${var.etcd_instance_type}"
  etcd_private_ip_from = "10"

  force_destroy = "${var.force_destroy}"
}

module "kubernetes" {
  source = "./modules/kubernetes"

  env = "${var.env}"
  region = "${var.region}"
  vpc_id = "${module.vpc.vpc_id}"

  private_subnet_ids = "${module.vpc.private_subnet_ids}"
  private_subnet_cidrs = "${module.vpc.private_subnet_cidrs}"
  private_dns_zone_id = "${module.vpc.private_dns_zone_id}"
  private_dns_zone_name = "${var.private_dns_zone_name}"

  ca_key_algorithm = "${module.ca.ca_key_algorithm}"
  ca_private_key_pem = "${module.ca.ca_private_key_pem}"
  ca_cert_pem = "${module.ca.ca_cert_pem}"

  coreos_ami = "${var.coreos_ami}"
  deployer_key_name = "${module.vpc.deployer_key_name}"
  default_security_group_id = "${module.vpc.default_security_group_id}"

  master_common_name = "master"
  master_hostname = "master.${var.env}-master"
  master_instance_type = "${var.master_instance_type}"
  master_private_ip = "${cidrhost(element(private_subnet_cidrs, 0), 20)}"
  etcd_endpoints = "${module.etcd.endpoints}"

  worker_common_names = [
    "worker0",
    "worker1",
  ]
  worker_hostnames = [
    "worker0.${var.env}-worker",
    "worker1.${var.env}-worker",
  ]
  worker_instance_type = "${var.worker_instance_type}"
  worker_private_ip_from = "30"

  force_destroy = "${var.force_destroy}"
}

/*module "registry" {
  source = "./modules/registry"

  env = "${var.env}"
  region = "${var.region}"
  vpc_id = "${module.vpc.vpc_id}"

  private_subnet_ids = "${module.vpc.private_subnet_ids}"
  private_dns_zone_id = "${module.vpc.private_dns_zone_id}"
  private_dns_zone_name = "${var.private_dns_zone_name}"

  ca_key_algorithm = "${module.ca.ca_key_algorithm}"
  ca_private_key_pem = "${module.ca.ca_private_key_pem}"
  ca_cert_pem = "${module.ca.ca_cert_pem}"

  coreos_ami = "${var.coreos_ami}"
  deployer_key_name = "${module.vpc.deployer_key_name}"
  default_security_group_id = "${module.vpc.default_security_group_id}"
  user_security_group_ids = []

  registry_instance_type = "${var.registry_instance_type}"
  registry_private_ip = "${cidrhost(element(private_subnet_cidrs, 0), 5)}"
  registry_port = "${var.registry_port}"

  force_destroy = "${var.force_destroy}"
}*/
