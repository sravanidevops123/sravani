provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA2D6MKHV5AEVPAP64"
  secret_key = "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"
}

resource "aws_instance" "awsinsta" {
  ami             = "ami-068257025f72f470d "
  instance_type   = "t2.micro"
  security_groups = ["launch-wizard-1"]
  key_name        = "demo"
  tags = {
    Name = "terraform"
  }
}
