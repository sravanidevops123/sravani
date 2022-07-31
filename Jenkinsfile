pipeline{
agent any
	
environment{
	AWS_CREDS = credentials('aws-credentials')
	AWS_ACCESS_KEY_ID     = "${env.AWS_CREDS_USR}" 
	AWS_SECRET_ACCESS_KEY = "${env.AWS_CREDS_PSW}"
	
}
	tools {
    	maven 'maven-3.6.3'
	terraform 'terraform-0.14.5'
    }
	stages{
  stage("Generating artifact"){
		steps{
			script{
				
			sh "mvn clean package"
		}
		}
		}
	stage("credentials"){
		steps{
		withCredentials([file(credentialsId: 'private-key', variable: 'privateKey')]) {
	   		sh """
                           if [ -f "Ec2.pem" ]
			    then
				echo "File found"
					else
				cat $privateKey > Ec2.pem
				chmod 400 Ec2.pem || true
     				fi
				"""
			
		}			
		}
	}
	stage("Terraform init"){
		steps{
			sh "terraform init"
			sh "terraform plan"
			
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
	
	}
}

		
		
