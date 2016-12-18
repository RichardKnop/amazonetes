data "template_file" "master_cloud_config" {
  template = "${file("${path.module}/templates/master-cloud-config.yml")}"

  vars {
    hostname = "${var.master_hostname}"
    ca_cert = "${base64encode(var.ca_cert_pem)}"
    master_key = "${base64encode(tls_private_key.master.private_key_pem)}"
    master_cert = "${base64encode(tls_locally_signed_cert.master.cert_pem)}"
    etcd_endpoints = "${var.etcd_endpoints}"
    kubernetes_version = "${var.kubernetes_version}"
    network_plugin = "" # leave this blank unless you want to use Calico
    dns_service_ip = "${var.dns_service_ip}"
    service_ip_range = "${var.service_ip_range}"
    pod_network = "${var.pod_network}"
    cluster_domain = "${var.cluster_domain}"
  }
}

resource "aws_instance" "master" {
  ami = "${var.coreos_ami}"
  instance_type = "${var.master_instance_type}"
  subnet_id = "${element(var.private_subnet_ids, 0)}"
  private_ip = "${var.master_private_ip}"
  iam_instance_profile = "${aws_iam_instance_profile.master.name}"

  root_block_device = {
    volume_type = "gp2"
    volume_size = 10
  }

  vpc_security_group_ids = [
    "${var.default_security_group_id}",
    "${aws_security_group.master.id}",
    "${var.etcd_client_security_group_id}",
  ]

  key_name = "${var.deployer_key_name}"

  tags = {
    OS = "coreos"
    Name = "${var.env}-master"
    Environment = "${var.env}"
  }

  user_data = "${data.template_file.master_cloud_config.rendered}"
}
