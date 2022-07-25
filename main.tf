provider "aws" {
  region     = "ap-northeast-3"
  
}

resource "aws_instance" "awsinsta" {
  ami             = "ami-044921b7897a7e0da"
  instance_type   = "t2.micro"
  security_groups = ["launch-wizard-1"]
  key_name        = "new-jenkins"
 
provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroy-time provisioner'"
  }
  
  provisioner "file" {
    source      = "target/vtdemo.war"
    destination = "~/vtdemo.war"
  }
  
   connection {
    type     = "ssh"
    user     = "ec2-user"
    #password = var.root_password
    private_key = file("new-jenkins.pem")
    host     = self.public_ip
  }
  
  provisioner "remote-exec" {
    script="downloadtomcatjava.sh"
  }
  
  provisioner "remote-exec" {
    script="starttomcat.sh"
  }
   tags = {
    Name = "terraform"
  }

}

output "my_publi_ip" {
  value = aws_instance.awsinsta.public_ip
}
