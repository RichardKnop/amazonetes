data "template_file" "assume_role_policy" {
  template = "${file("${path.module}/templates/assume-role-policy.json")}"
}

resource "aws_iam_role" "etcd" {
  name = "${var.env}-etcd-iam-role"
  assume_role_policy = "${data.template_file.assume_role_policy.rendered}"
}

data "template_file" "s3_policy" {
  template = "${file("${path.module}/templates/s3-policy.json")}"
}

resource "aws_iam_role_policy" "s3" {
  name = "${var.env}-etcd-iam-policy-s3"
  role = "${aws_iam_role.etcd.id}"
  policy = "${data.template_file.s3_policy.rendered}"
}

resource "aws_iam_instance_profile" "etcd" {
  name = "${var.env}-etcd-iam-profile"
  roles = ["${aws_iam_role.etcd.name}"]
}
