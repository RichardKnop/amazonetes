output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "deployer_key_name" {
  value = "${aws_key_pair.deployer.key_name}"
}

output "private_dns_zone_id" {
  value = "${aws_route53_zone.private.id}"
}

output "private_subnet_ids" {
  value = ["${aws_subnet.private.*.id}"]
}

output "private_subnet_cidrs" {
  value = ["${aws_subnet.private.*.cidr_block}"]
}

output "public_subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "private_route_table" {
  value = "${aws_route_table.private.id}"
}

output "default_security_group_id" {
  value = "${aws_security_group.default.id}"
}

output "web_security_group_id" {
  value = "${aws_security_group.web.id}"
}

output "nat_public_ip" {
  value = "${aws_instance.nat.public_ip}"
}
