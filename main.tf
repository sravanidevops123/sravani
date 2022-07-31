provider "aws" {
  region     = "ap-northeast-3"
  
}

resource "aws_instance" "awsinsta" {
  ami             = "ami-044921b7897a7e0da"
  instance_type   = "t2.micro"
  security_groups = ["launch-wizard-2"]
  key_name        = var.key_name
  tags = {
    Name = "TerraformOS"
  }
 provisioner "local-exec" {
    #when    = destroy
    command = <<EOT
	  echo "${self.public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=${var.key_name}.pem" > hosts;
    export ANSIBLE_HOST_KEY_CHECKING=False;
    cat hosts
	  ansible-playbook -i hosts tomcat.yaml
    EOT
  }
}
