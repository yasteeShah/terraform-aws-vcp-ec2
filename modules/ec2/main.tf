data "aws_ami" "linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}
resource "aws_security_group" "sandbox" {
  name        = "${var.name}-sg"
  description = var.sg == "web" ? "public web sg" : "private sg"
  vpc_id      = var.vpc_id
  tags        = merge(var.tags, { Name = "${var.name}-sg" })
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  security_group_id = aws_security_group.sandbox.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "http_80" {
  count             = var.sg == "web" ? 1 : 0
  type              = "ingress"
  security_group_id = aws_security_group.sandbox.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh_rule" {
  count             = var.ssh_cidr == null ? 0 : 1
  type              = "ingress"
  security_group_id = aws_security_group.sandbox.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.ssh_cidr]
}

resource "aws_instance" "sandbox" {
  ami                         = data.aws_ami.linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.sandbox.id]
  associate_public_ip_address = var.associate_public_ip
  user_data                   = var.user_data
  tags                        = merge(var.tags, { Name = var.name })
}
