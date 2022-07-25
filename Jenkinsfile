pipeline{
agent any
	
environment{
	MAVEN_OPTS="-Xmx512m"
	AWS_CREDS = credentials('aws-credentials')
	AWS_ACCESS_KEY_ID     = "${env.AWS_CREDS_USR}" 
	AWS_SECRET_ACCESS_KEY = "${env.AWS_CREDS_PSW}"
	
}
 tools {
    	maven 'maven-3.6.3'
	jdk 'JDK8u221'
	terraform 'terraform-0.14.5'
    }
	stages{
  stage("Packaging"){
		steps{
			script{
				
			sh "mvn clean package"
		}
		}
		}
	stage("Copying Private Key"){
		steps{
		withCredentials([file(credentialsId: 'privatekey', variable: 'privateKey')]) {
	   		sh '''
if [ -f "new-jenkins.pem" ]
then
echo "File found"
else
cat $privateKey > new-jenkins.pem
chmod 400 new-jenkins.pem || true
fi
			
			'''
			}
		}
	}
	stage("Terraform Plan"){
		steps{
			sh '''	
				alias tf="terraform"
				tf init
				tf plan
			'''
		}
	}
	
	stage("Deploy using Terraform"){
		steps{
			sh """
				alias tf="terraform"
				tf destroy -auto-approve || true
				tf apply -auto-approve || true
			"""
		}
	}
	post{
	success{
		archiveArtifacts 'TestWebApp/target/*.war'
	}
}
	}
}

		
		
		
