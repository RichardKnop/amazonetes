data "template_file" "assume_role_policy" {
  template = "${file("${path.module}/templates/assume-role-policy.json")}"
}

resource "aws_iam_role" "registry" {
  name = "${var.env}-registry-iam-role"
  assume_role_policy = "${data.template_file.assume_role_policy.rendered}"
}

data "template_file" "s3_policy" {
  template = "${file("${path.module}/templates/s3-policy.json")}"
}

resource "aws_iam_role_policy" "s3" {
  name = "${var.env}-registry-iam-policy-s3"
  role = "${aws_iam_role.registry.id}"
  policy = "${data.template_file.s3_policy.rendered}"
}

resource "aws_iam_instance_profile" "registry" {
  name = "${var.env}-registry-iam-profile"
  roles = ["${aws_iam_role.registry.name}"]
}
