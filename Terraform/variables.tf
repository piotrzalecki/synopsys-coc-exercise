variable "aws_region" {
  description = "Region for the VPC"
  default = "eu-west-1"
}

variable "aws_credentials_profile"{
    description = "Name of AWS credentials profile to use"
    default = "default"
}



variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default = "10.0.2.0/24"
}

variable "ami" {
  description = "AMI for EC2"
  default = "ami-06358f49b5839867c"
}

# variable "key_path" {
#   description = "SSH Public Key path"
#   default = "/home/core/.ssh/id_rsa.pub"
# }