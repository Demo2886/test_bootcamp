pipeline {
    agent any

    environment {
        DOCKER_ID = credentials('Usage')
        DOCKER_PASSWORD = credentials('DockerHub')
    }

    stages {
        stage('Init') {
            steps {
                echo 'Initializing..'
                echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
                echo "Current branch: ${env.BRANCH_NAME}"
                sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_ID --password-stdin'
            }
        }
        stage('Build') {
            steps {
                echo 'Building image..'
                sh 'docker build -t $DOCKER_ID/test-jenkins:latest .'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh 'docker run --rm -e CI=true $DOCKER_ID/test-jenkins pytest'
            }
        }
        stage('Publish') {
            steps {
                echo 'Publishing image to DockerHub..'
                sh 'docker push $DOCKER_ID/test-jenkins:latest'
            }
        }
        stage('Cleanup') {
            steps {
                echo 'Removing unused docker containers and images..'
                sh 'docker ps -aq | xargs --no-run-if-empty docker rm'
                // keep intermediate images as cache, only delete the final image
                sh 'docker images -q | xargs --no-run-if-empty docker rmi'
            }
        }
    }
}
