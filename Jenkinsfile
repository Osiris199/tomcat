pipeline {

  environment {
    HOME = "${env.WORKSPACE}"
    dockerimagename = "vaibhavx7/tomcat-soapui"
    dockerImage = ""
    buildNumber = "${currentBuild.number}"
  }

  agent any

  stages {

    stage('Stop all container') {
      steps{
        script {
          try {
              if(checkOsLinux()){
                sh "docker ps -q | xargs docker stop"
              } else {
                bat '''for /f "tokens=*" %%i in ('docker ps -q') do (docker stop %%i)'''
              }
          } catch (Exception e) {
              echo "entered catch block"       
          }
        }
      }
    }

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
                  bat "docker build -t ${dockerimagename}:${buildNumber} ."
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
                bat "docker push ${dockerimagename}:${buildNumber}"
              }
            }
        }
      }
    }

    stage('Running container') {
      steps {
        script {
          if(checkOsLinux()){
              sh "docker run -d --name tomcat_${buildNumber} -p 9090:8080 ${dockerimagename}"
          } else {
              bat "docker run -d --name tomcat_${buildNumber} -p 9090:8080 ${dockerimagename}:${buildNumber}"
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
