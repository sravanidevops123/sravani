provider "aws" {
  region     = "ap-northeast-3"
  
}

resource "aws_instance" "awsinsta" {
  ami             = "ami-044921b7897a7e0da"
  instance_type   = "t2.micro"
  security_groups = ["launch-wizard-1"]
  key_name        = "new-jenkins"
 
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
    inline= [
      "sudo yum update -y && sudo yum install java-1.8.0-openjdk wget -y",
      "sudo chown ec2-user:ec2-user /opt/",
      "wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.41/bin/apache-tomcat-8.5.41.tar.gz &",
      "sleep 15s",
      "tar -xzvf apache-tomcat-8.5.41.tar.gz",
      "mv apache-tomcat-8.5.41 /opt/tomcat8.5.41 "
      ]
  }
  
  provisioner "remote-exec" {
    inline= [
      "cp ~/vtdemo.war /opt/tomcat8.5.41/webapps",
     "nohup sh /opt/tomcat8.5.41/bin/startup.sh",
    "ps -ef | grep java"
      ]
  }
   tags = {
    Name = "terraform"
  }

}

output "my_publi_ip" {
  value = aws_instance.awsinsta.public_ip
}
