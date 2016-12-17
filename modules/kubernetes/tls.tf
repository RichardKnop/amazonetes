resource "tls_private_key" "master" {
  algorithm = "ECDSA"
  ecdsa_curve = "P521"
}

resource "tls_private_key" "admin" {
  algorithm = "ECDSA"
  ecdsa_curve = "P521"
}

resource "tls_private_key" "worker" {
  count = "${length(var.worker_hostnames)}"
  algorithm = "ECDSA"
  ecdsa_curve = "P521"
}

resource "tls_cert_request" "master" {
  key_algorithm = "${tls_private_key.master.algorithm}"
  private_key_pem = "${tls_private_key.master.private_key_pem}"

  subject {
    common_name = "${var.master_common_name}"
    organization = "Your Company"
    country = "HK"
  }

  dns_names = [
    # private IP
    "${var.master_private_ip}",
    # private DNS alias
    "${var.master_hostname}.${var.private_dns_zone_name}",
    # hostname
    "${var.master_hostname}",
  ]
}

resource "tls_locally_signed_cert" "master" {
  cert_request_pem = "${tls_cert_request.master.cert_request_pem}"

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

resource "tls_cert_request" "admin" {
  key_algorithm = "${tls_private_key.admin.algorithm}"
  private_key_pem = "${tls_private_key.admin.private_key_pem}"

  subject {
    common_name = "${var.master_common_name}"
    organization = "Your Company"
    country = "HK"
  }

  dns_names = [
    # private IP
    "${var.master_private_ip}",
    # private DNS alias
    "${var.master_hostname}.${var.private_dns_zone_name}",
    # hostname
    "${var.master_hostname}",
  ]
}

resource "tls_locally_signed_cert" "admin" {
  cert_request_pem = "${tls_cert_request.admin.cert_request_pem}"

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

resource "tls_cert_request" "worker" {
  count = "${length(var.worker_hostnames)}"
  key_algorithm = "${tls_private_key.worker.*.algorithm[count.index]}"
  private_key_pem = "${tls_private_key.worker.*.private_key_pem[count.index]}"

  subject {
    common_name = "${var.worker_common_names[count.index]}"
    organization = "Your Company"
    country = "HK"
  }

  dns_names = [
    # private IP
    "${cidrhost(element(var.private_subnet_cidrs, count.index % length(var.private_subnet_cidrs)), var.worker_private_ip_from + (count.index / length(var.private_subnet_cidrs)))}",
    # private DNS alias
    "${var.worker_hostnames[count.index]}.${var.private_dns_zone_name}",
    # hostname
    "${var.worker_hostnames[count.index]}",
  ]
}

resource "tls_locally_signed_cert" "worker" {
  count = "${length(var.worker_hostnames)}"
  cert_request_pem = "${tls_cert_request.worker.*.cert_request_pem[count.index]}"

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
