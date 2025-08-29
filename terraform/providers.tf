terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0" # Use an appropriate version
    }
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