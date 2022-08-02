pipeline{
agent any
	

	tools {
    	maven 'maven-3.6.3'
	
    }
	stages{
  stage("build docker image"){
            steps{
                script{
            
                    sh "docker build -t tomcat:8.0.52 ."
            
                }
            }
        }
        stage('push docker image'){
            steps{
                script{
                    withCredentials([string(credentialsId: '86681', variable: 'dockerhubcred')]) {
                        sh "docker login -u 86681 -p ${dockerhubcred}"
                        sh "docker tag tomcat:8.0.52 86681/tomcat:8.0.52"
		    }
		}
	    }
	}
	}
		
}

		
		
