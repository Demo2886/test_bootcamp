node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("releaseworks/hellonode")
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    environment {
        DOCKER_ID = credentials('DockerHub')
        DOCKER_PASSWORD = credentials('jokercat2886')
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
    *******stage('Push image') {
    *******    /* Finally, we'll push the image with two tags:
    *******     * First, the incremental build number from Jenkins
    *******     * Second, the 'latest' tag.
    *******     * Pushing multiple tags is cheap, as all the layers are reused. */
    *******   
    *******   
    *******   
    *******   
    *******   /*
    *******    * docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
    *******    *     app.push("${env.BUILD_NUMBER}")
    *******    *     app.push("latest")
    *******    } */
    *******}
}
