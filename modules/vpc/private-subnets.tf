resource "aws_subnet" "private" {
  count = 2
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${lookup(var.private_cidrs, format("zone%d", count.index))}"
  availability_zone = "${lookup(var.availability_zones, format("zone%d", count.index))}"
  map_public_ip_on_launch = false
  tags {
    Name = "${var.env}-private-subnet-${count.index}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}

resource "aws_route_table_association" "private" {
  count = 2
  subnet_id = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.id}"
}
