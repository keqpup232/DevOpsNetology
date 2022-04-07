terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  #connect
  backend "s3" {
    bucket = "keqpup232"
    key    = "terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform_state"
  }
}