output "ca_public_key_file_path" {
  value = var.ca_public_key_file_path
}

output "public_key_file_path" {
  value = var.public_key_file_path
}

output "private_key_file_path" {
  value = var.private_key_file_path
}

output "tls_files" {
  value = [
    tls_self_signed_cert.ca.cert_pem,
    tls_private_key.cert.private_key_pem,
    tls_locally_signed_cert.cert.cert_pem,
  ]
}