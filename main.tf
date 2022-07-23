provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA2D6MKHV5AEVPAP64"
  secret_key = "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"
}

resource "aws_instance" "awsinsta" {
  ami             = "ami-068257025f72f470d"
  instance_type   = "t2.micro"
  security_groups = ["launch-wizard-1"]
  key_name        = "demo"
  tags = {
    Name = "terraform"
  }

provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroy-time provisioner'"
  }
  
  provisioner "file" {
    source      = "/target/vtdemo.war"
    destination = "~/vtdemo.war"
  }
  
   connection {
    type     = "ssh"
    user     = "ubuntu"
    #password = var.root_password
    private_key = file("demo.pem")
    host     = self.public_ip
  }
  
  provisioner "remote-exec" {
    script="downloadtomcat&java.sh"
  }
  
  provisioner "remote-exec" {
    script="start tomcat.sh"
  }
}

output "my_publi_ip" {
  value = aws_instance.web.public_ip
}
