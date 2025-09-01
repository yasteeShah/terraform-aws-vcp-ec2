module "vpc" {
  source               = "./modules/vpc"
  name                 = var.name_prefix
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = var.tags
}

module "web" {
  source              = "./modules/ec2"
  name                = "${var.name_prefix}-web"
  vpc_id              = module.vpc.vpc_id
  subnet_id           = module.vpc.public_subnet_ids[0]
  instance_type       = var.instance_type
  sg                  = "web"
  associate_public_ip = true
  user_data           = <<-EOF
                        #!/bin/bash
                        dnf update -y
                        dnf install -y nginx
                        systemctl enable nginx
                        systemctl start nginx
                        EOF
  tags                = var.tags
}

module "db" {
  source              = "./modules/ec2"
  name                = "${var.name_prefix}-db"
  vpc_id              = module.vpc.vpc_id
  subnet_id           = module.vpc.private_subnet_ids[0]
  instance_type       = var.instance_type
  sg                  = "db"
  ssh_cidr            = var.vpc_cidr
  associate_public_ip = false
  user_data           = null
  tags                = var.tags
}
