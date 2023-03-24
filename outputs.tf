/* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
   SPDX-License-Identifier: MIT-0 */

# Outputs that will dsiplay to the terminal window.

# --- root/outputs.tf ---

# output "vpc_id" {
#   value       = module.vpc.vpc_id
#   description = "Output of VPC id created."
# }

# output "initial_sg_id" {
#   value       = module.vpc.initial_sg_id
#   description = "Output of initial sg id created."
# }

output "vpc_id" {
  description = "VPC ID"
  value       = module.iac_vpc.vpc_attributes.id
}

output "subnet_id" {
      description = "Map of public subnet attributes grouped by az."
      value = module.iac_vpc.public_subnet_attributes_by_az.us-west-2a.id
}

output "initial_sg_id" {
    value = module.initial-security-group.security_group_id
}