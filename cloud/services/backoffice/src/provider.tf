terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.4.1"
    }
  }
}

provider "aws" {
  profile = "terraform-user"
  region  = "us-east-1"
}
