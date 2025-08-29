output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "web_instance_id" {
  value = module.web.instance_id
}

output "web_public_ip" {
  value = module.web.public_ip
}

output "web_security_group_id" {
  value = module.web.security_group_id
}
