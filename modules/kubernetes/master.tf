data "template_file" "master_cloud_config" {
  template = "${file("${path.module}/templates/master-cloud-config.yml")}"

  vars {
    hostname = "${var.env}-master"
    ca_cert = "${base64encode(var.ca_cert_pem)}"
    master_key = "${base64encode(tls_private_key.master.private_key_pem)}"
    master_cert = "${base64encode(tls_locally_signed_cert.master.cert_pem)}"
    etcd_endpoints = "${var.etcd_endpoints}"
    k8s_version = "v1.4.3_coreos.0"
    network_plugin = ""
    dns_service_ip = "10.3.0.10"
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
  ]

  key_name = "${var.deployer_key_name}"

  tags = {
    OS = "coreos"
    Name = "${var.env}-master"
    Environment = "${var.env}"
  }

  user_data = "${data.template_file.master_cloud_config.rendered}"
}
