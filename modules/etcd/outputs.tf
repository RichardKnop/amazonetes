output "etcd_security_group_id" {
  value = "${aws_security_group.etcd.id}"
}

output "etcd_ids" {
  value = ["${aws_instance.etcd.*.id}"]
}

output "etcd_private_ips" {
  value = ["${aws_instance.etcd.*.private_ip}"]
}

output "etcd_domain_names" {
  value = ["${aws_route53_record.etcd_alias.*.fqdn}"]
}

output "etcd_iam_role_id" {
  value = "${aws_iam_role.etcd.id}"
}

output "etcd_iam_role_arn" {
  value = "${aws_iam_role.etcd.arn}"
}

output "endpoints" {
  value = "${join(",", formatlist("https://%s.%s:2379", var.etcd_hostnames, var.private_dns_zone_name))}"
}
