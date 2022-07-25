sudo apt-get update
sudo apt install default-jdk
sudo apt install https://download.oracle.com/otn/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64.rpm?AuthParam=1658759555_f55799326fe072a2ba18284b53cc979f
sudo chown ubuntu:ubuntu /opt/


wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.41/bin/apache-tomcat-8.5.41.tar.gz &
sleep 15s
tar -xzvf apache-tomcat-8.5.41.tar.gz
mv apache-tomcat-8.5.41 /opt/tomcat8.5.41
