provider "aws" {
  region     = "ap-south-1"
  
}

resource "aws_instance" "awsinsta" {
  ami             = "ami-08df646e18b182346"
  instance_type   = "t2.micro"
  security_groups = ["launch-wizard-2"]
  key_name        = var.key_name
  tags = {
    Name = "Terraform"
  }
 provisioner "local-exec" {
    #when    = destroy
    command = <<EOT
	  echo "${self.public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=${var.key_name}.pem" > hosts;
    export ANSIBLE_HOST_KEY_CHECKING=False;
    cat hosts
	  ansible-playbook -i hosts java-tom.yaml
    EOT
  }
}

output "my_publi_ip" {
  value = aws_instance.awsinsta.public_ip
}
