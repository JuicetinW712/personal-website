terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# ACM only supports us-east-1
provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}