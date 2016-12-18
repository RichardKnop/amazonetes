resource "tls_private_key" "server" {
  count = "${length(var.etcd_hostnames)}"
  algorithm = "ECDSA"
  ecdsa_curve = "P521"
}

resource "tls_private_key" "client_server" {
  count = "${length(var.etcd_hostnames)}"
  algorithm = "ECDSA"
  ecdsa_curve = "P521"
}

resource "tls_private_key" "client" {
  count = "${length(var.etcd_hostnames)}"
  algorithm = "ECDSA"
  ecdsa_curve = "P521"
}

resource "tls_cert_request" "server" {
  count = "${length(var.etcd_hostnames)}"
  key_algorithm = "${tls_private_key.server.*.algorithm[count.index]}"
  private_key_pem = "${tls_private_key.server.*.private_key_pem[count.index]}"

  subject {
    common_name = "${var.etcd_common_names[count.index]}"
    organization = "Your Company"
    country = "HK"
  }

  dns_names = [
    # private IP
    "${cidrhost(element(var.private_subnet_cidrs, count.index % length(var.private_subnet_cidrs)), var.etcd_hostnum_from + (count.index / length(var.private_subnet_cidrs)))}",
    # private DNS alias
    "${var.etcd_hostnames[count.index]}.${var.private_dns_zone_name}",
    # hostname
    "${var.etcd_hostnames[count.index]}",
  ]
}

resource "tls_locally_signed_cert" "server" {
  count = "${length(var.etcd_hostnames)}"
  cert_request_pem = "${tls_cert_request.server.*.cert_request_pem[count.index]}"

  ca_key_algorithm = "${var.ca_key_algorithm}"
  ca_private_key_pem = "${var.ca_private_key_pem}"
  ca_cert_pem = "${var.ca_cert_pem}"

  validity_period_hours = 87600 # 10 years

  allowed_uses = [
    "signing",
    "key encipherment",
    "server auth",
  ]
}

resource "tls_cert_request" "client_server" {
  count = "${length(var.etcd_hostnames)}"
  key_algorithm = "${tls_private_key.client_server.*.algorithm[count.index]}"
  private_key_pem = "${tls_private_key.client_server.*.private_key_pem[count.index]}"

  subject {
    common_name = "${var.etcd_common_names[count.index]}"
    organization = "Your Company"
    country = "HK"
  }

  dns_names = [
    # private IP
    "${cidrhost(element(var.private_subnet_cidrs, count.index % length(var.private_subnet_cidrs)), var.etcd_hostnum_from + (count.index / length(var.private_subnet_cidrs)))}",
    # private DNS alias
    "${var.etcd_hostnames[count.index]}.${var.private_dns_zone_name}",
    # hostname
    "${var.etcd_hostnames[count.index]}",
  ]
}

resource "tls_locally_signed_cert" "client_server" {
  count = "${length(var.etcd_hostnames)}"
  cert_request_pem = "${tls_cert_request.client_server.*.cert_request_pem[count.index]}"

  ca_key_algorithm = "${var.ca_key_algorithm}"
  ca_private_key_pem = "${var.ca_private_key_pem}"
  ca_cert_pem = "${var.ca_cert_pem}"

  validity_period_hours = 87600 # 10 years

  allowed_uses = [
    "signing",
    "key encipherment",
    "server auth",
    "client auth",
  ]
}

resource "tls_cert_request" "client" {
  count = "${length(var.etcd_hostnames)}"
  key_algorithm = "${tls_private_key.client.*.algorithm[count.index]}"
  private_key_pem = "${tls_private_key.client.*.private_key_pem[count.index]}"

  subject {
    common_name = "${var.etcd_common_names[count.index]}"
    organization = "Your Company"
    country = "HK"
  }

  dns_names = [
    # private IP
    "${cidrhost(element(var.private_subnet_cidrs, count.index % length(var.private_subnet_cidrs)), var.etcd_hostnum_from + (count.index / length(var.private_subnet_cidrs)))}",
    # private DNS alias
    "${var.etcd_hostnames[count.index]}.${var.private_dns_zone_name}",
    # hostname
    "${var.etcd_hostnames[count.index]}",
  ]
}

resource "tls_locally_signed_cert" "client" {
  count = "${length(var.etcd_hostnames)}"
  cert_request_pem = "${tls_cert_request.client.*.cert_request_pem[count.index]}"

  ca_key_algorithm = "${var.ca_key_algorithm}"
  ca_private_key_pem = "${var.ca_private_key_pem}"
  ca_cert_pem = "${var.ca_cert_pem}"

  validity_period_hours = 87600 # 10 years

  allowed_uses = [
    "signing",
    "key encipherment",
    "client auth",
  ]
}
