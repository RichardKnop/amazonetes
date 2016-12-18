resource "aws_security_group" "master" {
  name = "${var.env}-kubernetes-master-sg"
  description = "Security group for master node"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-kubernetes-master-sg"
  }
}

resource "aws_security_group" "worker" {
  name = "${var.env}-kubernetes-worker-sg"
  description = "Security group for worker nodes"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-kubernetes-worker-sg"
  }
}
