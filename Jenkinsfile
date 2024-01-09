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
              sh 'jar -cvf test.war *'
            } else {
              bat 'jar -cvf test.war *'
            }
        }
      }
    }

    // stage('Build image') {
    //   steps{
    //     dir("${env.WORKSPACE}"){
    //       bat "docker build -t tomcat ."
    //   }
    //   }
    // }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build(dockerimagename, "-f ./${env.WORKSPACE}/Dockerfile .")
        }
      }
    }

    stage('Pushing Images') {
      environment {
          registryCredential = 'Docker_Hub_cred'
      }
      steps{
        script {
            docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }

    stage('Running container') {
      steps {
        script {
          if(checkOsLinux()){
              sh "docker run -d --name tomcat -p 9090:8080 ${dockerimagename}"
          } else {
              bat "docker run -d --name tomcat -p 9090:8080 ${dockerimagename}"
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
