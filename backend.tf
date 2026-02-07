terraform {
  backend "s3" {
    bucket         = "terraform-platform-state-bucket"
    key            = "global/terraform.tfstate" # static for init
    region         = "ap-south-1"
    dynamodb_table = "terraform-platform-lock"
    encrypt        = true
  }
}

