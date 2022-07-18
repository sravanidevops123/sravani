pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven"
    }

    stages {
        
        
         stage("Maven Build") {
           steps {
                script {
                    sh "mvn clean package -DskipTests=true"
                }
            }
        }
        stage("build docker image"){
            steps{
                script{
            
                    sh "docker build -t tomcat:8.0.53 ."
            
                }
            }
        }
        stage('push docker image'){
            steps{
                script{
                    withCredentials([string(credentialsId: '86681', variable: 'dockerhubcred')]) {
                        sh "docker login -u 86681 -p ${dockerhubcred}"
                        sh "docker tag tomcat:8.0.53 86681/tomcat:8.0.53 "
                        sh 'docker push 86681/tomcat:8.0.53 '
                    }
                }
            }
        }

                  stage('deployment in kubernetes'){
                      steps{
                          script{
                              
                            sh 'kubectl delete -f depolyment.yml || true'  
                              
                            sh 'kubectl apply -f depolyment.yml '
                          }
                      }
                  }  
                }
            }
        
