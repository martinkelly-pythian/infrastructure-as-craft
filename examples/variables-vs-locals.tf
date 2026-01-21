# Here's an example, abstracted from code I found recently, first with a separate locals file.

# variables.tf
variable "environment" {
  description = "Deployment environment (e.g. dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

# locals.tf
locals {
  env    = var.environment
  aws_region = var.region
}
# main.tf
provider "aws" {
  region = local.aws_region
}

resource "aws_s3_bucket" "example" {
  bucket = "my-app-${local.env}-bucket"

  tags = {
    Environment = local.env
  }
}

# Next directly referenced variables. no double lookup, much faster to follow the logic, much less code

# variables.tf
variable "environment" {
  description = "Deployment environment (e.g. dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

# main.tf
provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "example" {
  bucket = "my-app-${var.environment}-bucket"

  tags = {
    Environment = var.environment
  }
}
