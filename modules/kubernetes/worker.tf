data "template_file" "worker_cloud_config" {
  count = "${length(var.worker_hostnames)}"
  template = "${file("${path.module}/templates/worker-cloud-config.yml")}"

  vars {
    hostname = "${var.worker_hostnames[count.index]}"
    ca_cert = "${base64encode(var.ca_cert_pem)}"
    worker_key = "${base64encode(tls_private_key.worker.*.private_key_pem[count.index])}"
    worker_cert = "${base64encode(tls_locally_signed_cert.worker.*.cert_pem[count.index])}"
    etcd_endpoints = "${var.etcd_endpoints}"
    kubernetes_version = "${var.kubernetes_version}"
    master_host = "${aws_route53_record.master_alias.fqdn}"
    network_plugin = "" # leave this blank unless you want to use Calico
    dns_service_ip = "${var.dns_service_ip}"
    pod_network = "${var.pod_network}"
    cluster_domain = "${var.cluster_domain}"
  }
}
