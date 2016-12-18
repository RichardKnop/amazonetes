data "template_file" "cloud_config" {
  count = "${length(var.etcd_hostnames)}"
  template = "${file("${path.module}/templates/cloud-config.yml")}"

  vars {
    hostname = "${var.etcd_hostnames[count.index]}"
    first_endpoint = "${format("https://%s.%s", var.etcd_hostnames[count.index], var.private_dns_zone_name)}"
    etcd_endpoints = "${join(",", formatlist("https://%s.%s:2379", var.etcd_hostnames, var.private_dns_zone_name))}"
    ca_cert = "${base64encode(var.ca_cert_pem)}"
    server_key = "${base64encode(tls_private_key.server.*.private_key_pem[count.index])}"
    server_cert = "${base64encode(tls_locally_signed_cert.server.*.cert_pem[count.index])}"
    client_server_key = "${base64encode(tls_private_key.client_server.*.private_key_pem[count.index])}"
    client_server_cert = "${base64encode(tls_locally_signed_cert.client_server.*.cert_pem[count.index])}"
    client_key = "${base64encode(tls_private_key.client.*.private_key_pem[count.index])}"
    client_cert = "${base64encode(tls_locally_signed_cert.client.*.cert_pem[count.index])}"
    region = "${var.region}"
    cluster_id = "${var.cluster_id}"
  }
}

resource "aws_instance" "etcd" {
  count = "${length(var.etcd_hostnames)}"
  ami = "${var.coreos_ami}"
  instance_type = "${var.etcd_instance_type}"
  subnet_id = "${element(var.private_subnet_ids, count.index % length(var.private_subnet_ids))}"
  private_ip = "${cidrhost(element(var.private_subnet_cidrs, count.index % length(var.private_subnet_cidrs)), var.etcd_hostnum_from + (count.index / length(var.private_subnet_cidrs)))}"
  iam_instance_profile = "${aws_iam_instance_profile.etcd.name}"

  root_block_device = {
    volume_type = "gp2"
    volume_size = 10
  }

  vpc_security_group_ids = [
    "${var.default_security_group_id}",
    "${aws_security_group.etcd_peer.id}",
    "${aws_security_group.etcd_client.id}",
    "${aws_security_group.etcd.id}",
  ]

  key_name = "${var.deployer_key_name}"

  tags = {
    OS = "coreos"
    Name = "${var.cluster_id}-etcd-${count.index}"
    Environment = "${var.env}"
  }

  user_data = "${data.template_file.cloud_config.*.rendered[count.index]}"
}
