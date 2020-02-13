output "Connect_to_Bastion" {
  value = "ssh -i ${aws_key_pair.key.key_name}.pem ubuntu@${aws_instance.bastion.public_ip}"
}