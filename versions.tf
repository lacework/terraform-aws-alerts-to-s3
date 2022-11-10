terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    lacework = {
      source = "lacework/lacework"
      version = "~> 0.20.0"
    }
  }
}