terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.5.0"
    }
  }
  required_version = ">=1.1.6"
}
