pipeline {
    environment {
    registry = "jokercat2886/test-jenkins"
    registryCredential = 'DockerHub'
    docker_stop = '\$(docker ps -a -q)'
  }
  
  
      agent any //{label 'master'}
  stages {
    
    
    stage('Cloning Git') {
      steps {
        git url:'https://github.com/Demo2886/test_bootcamp.git', branch:'main'
      }
    }
    
  
    stage ("lint dockerfile") {
        agent {
            docker {
                image 'hadolint/hadolint:latest-debian'
                //image 'ghcr.io/hadolint/hadolint:latest-debian'
            }
        }
        steps {
            sh 'hadolint Dockerfile/* | tee -a hadolint_lint.txt'
        }
        post {
            always {
                archiveArtifacts 'hadolint_lint.txt'
            }
        }
    }

    stage('Building image') {
      steps{
        script {
          //dockerImage = docker.build("$registry:$BUILD_NUMBER")
          dockerImage = docker.build("$registry:latest")
        }
      }
    }
    stage('Test image') {
      steps{
        sh "docker run -p 8001:8000 -d $registry:latest"
        sleep 4
	sh "curl http://127.0.0.1:8001"
	sleep 4
	sh "docker stop $docker_stop"
	//sh 'docker ps -f name=zookeeper -q | xargs --no-run-if-empty docker container stop'
	//sh "ddocker ps -aq | xargs docker stop --all"
	sleep 10
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
