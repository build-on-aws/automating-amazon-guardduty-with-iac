/* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 SPDX-License-Identifier: MIT-0 */

# --- root/variables.tf ---

# AWS REGION
variable "aws_region" {
  type        = string
  description = "AWS Region to create the environment."
  default     = "us-west-2"
}

variable "vpc_id" {
  description = "VPC ID to use if not creating VPC."
  default     = null
  type        = string
}