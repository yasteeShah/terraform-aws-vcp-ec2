###################################################################
# Terraform AWS VPC with Public/Private Subnets and a Public EC2
###################################################################
What this creates

- 1 VPC: `10.0.0.0/16`
- 3 public subnets across distinct AZs, routed to an Internet Gateway
- 3 private subnets across distinct AZs, no direct Internet route
- EC2 instance in a public subnet with a security group allowing TCP/80 from anywhere

###################################################################
# Prerequisites
###################################################################

- Terraform `>= 1.5`
- AWS provider `>= 5.0`
- AWS credentials configured (e.g. `aws configure`)

###################################################################
# Run the terraform code after terraform is installed
# Check the nginx is installed
###################################################################

cd terraform-aws-vpc-ec2
cp terraform.tfvars
terraform init
terraform plan
terraform apply -auto-approve

When apply completes, note `web_public_ip`. `http://<web_public_ip>` once you install nginx on the instance later.

###################################################################
# Varaibles and tfvars
###################################################################
variables.tf has defaults and override in terraform.tfvars.

###################################################################
# Destroy 
###################################################################
terraform destroy -auto-approve

###################################################################
# Note
###################################################################
- The EC2 AMI will be selected dynamically (latest Amazon Linux) per region.
