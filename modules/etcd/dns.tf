resource "aws_route53_record" "etcd_alias" {
  count = "${length(var.etcd_hostnames)}"
  zone_id = "${var.private_dns_zone_id}"
  name = "etcd${count.index}.${var.cluster_id}.${var.private_dns_zone_name}"
  type = "A"
  ttl = "60"
  records = ["${aws_instance.etcd.*.private_ip[count.index]}"]
}

resource "aws_route53_record" "etcd_srv_server" {
  zone_id = "${var.private_dns_zone_id}"
  name = "_etcd-server-ssl._tcp.${var.cluster_id}.${var.private_dns_zone_name}"
  type = "SRV"
  ttl = "60"
  records = ["${formatlist("0 0 2380 %s", aws_route53_record.etcd_alias.*.name)}"]
}

resource "aws_route53_record" "etcd_srv_client" {
  zone_id = "${var.private_dns_zone_id}"
  name = "_etcd-client-ssl._tcp.${var.cluster_id}.${var.private_dns_zone_name}"
  type = "SRV"
  ttl = "60"
  records = ["${formatlist("0 0 2379 %s", aws_route53_record.etcd_alias.*.name)}"]
}
