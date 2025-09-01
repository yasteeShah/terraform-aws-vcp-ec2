output "instance_id" {
  value = aws_instance.sandbox.id
}

output "public_ip" {
  value = aws_instance.sandbox.public_ip
}

output "private_ip" {
  value = aws_instance.sandbox.private_ip
}