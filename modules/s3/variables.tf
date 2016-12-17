variable "env" {
  type        = "string"
  description = "Environment name"
}

variable "region" {
  type        = "string"
  description = "AWS region"
}

variable "vpc_id" {
  type        = "string"
  description = "VPC ID"
}

variable "private_route_table" {
  type        = "string"
  description = "Private route table"
}

variable "uploader_iam_role_arn" {
  type        = "string"
  description = "ARN of an IAM role which can upload files to S3"
}

variable "force_destroy" {
  type        = "string"
  description = "Delete S3 buckets content"
}
