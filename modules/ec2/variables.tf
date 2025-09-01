variable "name" {
    type = string 
    }
variable "vpc_id" {
    type = string 
    }
variable "subnet_id" {
    type = string 
    }
variable "instance_type" {
    type = string 
    }
variable "sg" { 
   type = string 
   }
variable "ssh_cidr" { 
   type = string
   default = null 
   }
variable "associate_public_ip" { 
   type = bool
   default = false 
   }
variable "user_data" {
    type = string 
    default = null 
    }
variable "tags" {
    type = map(string)
     }
