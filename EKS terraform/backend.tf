terraform {
  backend "s3" {
    bucket = "eyego-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

