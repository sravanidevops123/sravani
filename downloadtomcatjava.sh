sudo apt-get update -y && sudo apt-get install openjdk-8-jre-headless wget -y
sudo chown ubuntu:ubuntu /opt/


wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.41/bin/apache-tomcat-8.5.41.tar.gz &
sleep 15s
tar -xzvf apache-tomcat-8.5.41.tar.gz
mv apache-tomcat-8.5.41 /opt/tomcat8.5.41
