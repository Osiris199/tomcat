pipeline {

  environment {
    HOME = "${env.WORKSPACE}"
    dockerimagename = "vaibhavx7/tomcat-soapui"
    dockerImage = ""
  }

  agent any

  stages {

    stage('SCM Checkout') {
      steps{
        script {
          git branch: 'feature/vaibhav', credentialsId: 'Github_cred', url: 'https://github.com/Osiris199/tomcat.git'
        }
      }
    }

    stage('Generate war file') {
      steps{
        script {
            if(checkOsLinux()){
              sh 'jar -cvf soapUI_services.war *'
            } else {
              bat 'jar -cvf soapUI_services.war *'
            }
        }
      }
    }

    stage('Build image') {
      steps{
        script {
          if(checkOsLinux()){
              dockerImage = docker.build(dockerimagename, "-f ${env.WORKSPACE}/Dockerfile .")
          } else {
               dir("${env.WORKSPACE}"){
                  bat "docker build -t ${dockerimagename}:1.0 ."
               }
          }
        }
      }
    }

    stage('Pushing Images') {
      environment {
          registryCredential = 'Docker_Hub_cred'
      }
      steps{
          script {
            if(checkOsLinux()){
                docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
                dockerImage.push("latest")
              }
            } else {
              withCredentials([string(credentialsId: 'Dockerhub_credential', variable: 'dockerhub_pwd')]) {
                bat "docker login -u vaibhavx7 -p ${dockerhub_pwd}"
                bat "docker push ${dockerimagename}:1.0"
              }
            }
        }
      }
    }

    stage('Running container') {
      steps {
        script {
          if(checkOsLinux()){
              sh "docker run -d --name tomcat -p 9090:8080 ${dockerimagename}t"
          } else {
              bat "docker run -d --name tomcat -p 9090:8080 ${dockerimagename}:1.0"
          }
        }
      }
    }
  }

}

def checkOsLinux(){
    if (isUnix()) {
        return true
    } else {
        return false
    }
}
