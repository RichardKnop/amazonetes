resource "aws_security_group" "master" {
  name = "${var.env}-kubernetes-master-sg"
  description = "Security group for master node"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [
      "${aws_security_group.worker.id}",
    ]
  }

  tags = {
    Name = "${var.env}-kubernetes-master-sg"
  }
}

resource "aws_security_group" "worker" {
  name = "${var.env}-kubernetes-worker-sg"
  description = "Security group for worker nodes"
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "${var.env}-kubernetes-worker-sg"
  }
}
