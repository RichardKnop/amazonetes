data "template_file" "assume_role_policy" {
  template = "${file("${path.module}/templates/assume-role-policy.json")}"
}

resource "aws_iam_role" "master" {
  name = "${var.env}-master-iam-role"
  assume_role_policy = "${data.template_file.assume_role_policy.rendered}"
}

data "template_file" "s3_policy" {
  template = "${file("${path.module}/templates/s3-policy.json")}"
}

resource "aws_iam_role_policy" "master_s3" {
  name = "${var.env}-master-iam-policy-s3"
  role = "${aws_iam_role.master.id}"
  policy = "${data.template_file.s3_policy.rendered}"
}

resource "aws_iam_instance_profile" "master" {
  name = "${var.env}-master-iam-profile"
  roles = ["${aws_iam_role.master.name}"]
}
