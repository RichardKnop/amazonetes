data "template_file" "registry_storage_bucket_policy" {
  template = "${file("${path.module}/templates/storage-bucket-policy.json")}"

  vars {
    env = "${var.env}"
    registry_iam_role_arn = "${aws_iam_role.registry.arn}"
  }
}

resource "aws_s3_bucket" "registry_storage" {
  bucket = "${var.env}.registry"
  acl = "private"
  force_destroy = "${var.force_destroy}"
  policy = "${data.template_file.registry_storage_bucket_policy.rendered}"

  tags {
    Name = "S3 bucket to act as Docker registry storage"
    Environment = "${var.env}"
  }
}
