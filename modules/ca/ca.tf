resource "tls_private_key" "ca" {
  algorithm = "ECDSA"
  ecdsa_curve = "P521"
}

resource "tls_self_signed_cert" "ca" {
  key_algorithm = "${tls_private_key.ca.algorithm}"
  private_key_pem = "${tls_private_key.ca.private_key_pem}"

  subject {
    common_name = "Your Company CA"
    organization = "Your Company"
    country = "HK"
  }

  validity_period_hours = 87600 # 10 years

  is_ca_certificate = true

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
    "cert_signing",
  ]
}
