resource "aws_security_group" "etcd_peer" {
  name = "${var.env}-${var.cluster_id}-etcd-peer-sg"
  description = "Security group for ETCD peer traffic"
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "${var.env}-${var.cluster_id}-etcd-peer-sg"
  }
}

resource "aws_security_group" "etcd_client" {
  name = "${var.env}-${var.cluster_id}-etcd-client-sg"
  description = "Security group for ETCD client traffic"
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "${var.env}-${var.cluster_id}-etcd-client-sg"
  }
}

resource "aws_security_group" "etcd" {
  name = "${var.env}-${var.cluster_id}-etcd-sg"
  description = "Security group for ETCD nodes that allows both client traffic and peer traffic between nodes"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port       = 2379
    to_port         = 2379
    protocol        = "tcp"
    security_groups = [
      "${aws_security_group.etcd_client.id}",
    ]
  }

  ingress {
    from_port       = 2380
    to_port         = 2380
    protocol        = "tcp"
    security_groups = [
      "${aws_security_group.etcd_peer.id}",
    ]
  }

  egress {
    from_port       = 2379
    to_port         = 2379
    protocol        = "tcp"
    security_groups = [
      "${aws_security_group.etcd_client.id}",
    ]
  }

  egress {
    from_port       = 2380
    to_port         = 2380
    protocol        = "tcp"
    security_groups = [
      "${aws_security_group.etcd_peer.id}",
    ]
  }

  tags = {
    Name = "${var.env}-${var.cluster_id}-etcd-sg"
  }
}
