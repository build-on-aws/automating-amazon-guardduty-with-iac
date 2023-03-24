/* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
   SPDX-License-Identifier: MIT-0 */

# --- root/main.tf ---

# CREATES VPC
module "iac_vpc" {
  source     = "aws-ia/vpc/aws"
  version    = "4.0.0"
  az_count   = 1
  name       = "GuardDuty-VPC"
  cidr_block = "10.0.0.0/24"
  

  subnets = {
    public = {
      name_prefix               = "gd_subnet"
      netmask                   = 26
      nat_gateway_configuration = "single_az"
    }
  }
}

# # CREATES INITIAL SECUIRTY GROUP
module "initial-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name        = "INITIAL_SG"
  description = "Initial Security group "
  vpc_id      = module.iac_vpc.vpc_attributes.id
}

# Gets the latest AMI resource and is used in the creation of the compute instances below:
data "aws_ami" "latest_amazonlinux2_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# CREATES COMPUTE INSTANCES
module "compute" {
  source         = "./modules/compute"
  ami_id         = data.aws_ami.latest_amazonlinux2_ami.id
  subnet_id      = module.iac_vpc.public_subnet_attributes_by_az.us-west-2a.id
  initial_sg_id   = module.initial-security-group.security_group_id
}

