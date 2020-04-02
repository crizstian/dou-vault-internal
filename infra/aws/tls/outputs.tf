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
  value = [{
    name = var.ca_public_key_file_path
    file = tls_self_signed_cert.ca.cert_pem
  },{
    name = var.private_key_file_path
    file = tls_private_key.cert.private_key_pem
  }, {
    name = var.public_key_file_path
    file = tls_locally_signed_cert.cert.cert_pem
  }]
}