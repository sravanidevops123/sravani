provider "aws" {
  region     = "ap-south-1"
  
}

resource "aws_instance" "awsinsta" {
  ami             = "ami-044921b7897a7e0da"
  instance_type   = "t2.micro"
  security_groups = ["launch-wizard-2"]
  key_name        = "Ec2"
  tags = {
    Name = "TerraformOS"
  }
}
 resource "local_sensitive_file" "ip" {
    content  = aws_instance.awsinsta.public_ip
    filename = "ip.txt"
 }
resource "null_resource" "nullremote1" {
depends_on = [aws_instance.awsinsta] 
connection {
    type     = "ssh"
    user     = "ec2-user"
    #password = var.root_password
    private_key = file("Ec2.pem")
    host     = self.public_ip
  }
  provisioner "file" {
    source      = "ip.txt"
    destination = "/ec2-user/ansible_terraform/aws_instance/ip.txt"
       }

provisioner "remote-exec" {
 inline = [
 "cd /root/ansible_terraform/aws_instance/",
 "ansible-playbook tomcat.yaml"
]
}
}
  

