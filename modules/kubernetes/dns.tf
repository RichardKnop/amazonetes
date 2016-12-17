resource "aws_route53_record" "master_alias" {
  zone_id = "${var.private_dns_zone_id}"
  name = "${var.master_hostname}.${var.private_dns_zone_name}"
  type = "A"
  ttl = "60"
  records = ["${aws_instance.master.*.private_ip}"]
}
