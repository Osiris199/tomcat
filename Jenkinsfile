pipeline {

  agent any

  stages {

    stage('SCM Checkout') {
      steps{
        script {
          git branch: 'master', credentialsId: 'Github', url: 'https://github.com/Osiris199/tomcat.git'
        }
      }
    }

    stage('Generate war file') {
      steps{
        script {
          bat 'jar -cvf test.war *'
        }
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build("testwarfile", "-f ${env.WORKSPACE}/Dockerfile .")
        }
      }
    }

  }

}
