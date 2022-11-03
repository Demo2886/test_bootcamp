pipeline {
    environment {
    registry = "jokercat2886/test-jenkins"
    registryCredential = 'DockerHub'
  }
  
  
      agent any //{label 'master'}
  stages {
    
    
    stage('Cloning Git') {
      steps {
        git url:'https://github.com/Demo2886/test_bootcamp.git', branch:'main'
      }
    }

    stage('Building image') {
      steps{
        script {
          //dockerImage = docker.build("$registry:$BUILD_NUMBER")
          dockerImage = docker.build registry + ":latest" , "--network host ."
        }
      }
    }
    stage('Test image') {
      steps{
        sh "docker run -i $registry:latest"
      }
    }

    stage('Push Image to repo') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
  }	
}
