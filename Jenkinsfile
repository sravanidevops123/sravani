pipeline{
agent any
	
environment{
	MAVEN_OPTS="-Xmx512m"
	AWS_CREDS = credentials('aws-credentials')
	AWS_ACCESS_KEY_ID     = "${env.AWS_CREDS_USR}" 
	AWS_SECRET_ACCESS_KEY = "${env.AWS_CREDS_PSW}"
	AWS_DEFAULT_REGION = "ap-south-1"
}
  tools {
    	maven 'maven'
	jdk 'JDK8u221'
	terraform 'terraform'
    }
  stage("Packaging"){
		steps{
					
			sh "mvn clean package"
			}
		}
	stage("Copying Private Key"){
		steps{
		withCredentials([file(credentialsId: 'myLap-pemkey', variable: 'privateKey')]) {
	   		sh '''
if [ -f "myLap.pem" ]
then
echo "File found"
else
cat $privateKey > myLap.pem
chmod 400 myLap.pem || true
fi
			
			'''
			}
		}
	}
