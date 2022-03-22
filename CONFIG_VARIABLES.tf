## Configures AWS provider
provider "aws" {
  region = var.region
  # version = "~> 2.0"
  version = "~> 3.0"
}

# Input Variables
############################
## AWS environments
variable "company" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "MZ"
}
variable "environment" {
  description = "What current stage is your resource "
  type        = string
  default     = "TRAINING"
}
variable "region" {
  description = "The region to deploy the cluster in, e.g: ap-northeast-2"
  type    = string
  default = "ap-northeast-2"
}
variable "key_pair" {
  description = "The EC2 Key name to deploy in, e.g: key_name"
  type    = string
  default = "seoul-ekgu-key"
}

############################
## VPC base parameters
variable "vpc-a_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}


############################
## VPC base parameters2 
variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}
variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}
variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}
variable "assign_generated_ipv6_cidr_block" {
  description = "Define whether to use ipv6"
  type        = string
  default     = "false"
}
