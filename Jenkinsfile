pipeline {

  agent any

  stages {

    stage('SCM Checkout') {
      steps{
        script {
          git branch: 'feature/vaibhav', credentialsId: 'siddhatech_test', url: 'https://github.com/RaghavendraPrabhu/siddhatechtest.git'
        }
      }
    }

    stage('Generate war file') {
      steps{
        script {
          sh 'jar -cvf test.war *'
        }
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build("testwarfile", "-f ${env.WORKSPACE} .")
        }
      }
    }

  }

}
