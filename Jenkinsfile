node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("jokercat2886/test-jenkins")
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'echo "Tests passed"'
        }
    }


    parameters {
        booleanParam(name: 'BUILD', defaultValue: true, description: 'do you want to build the app?')
    }
    stages {
        stage('Push image in repo?') {
            steps {
                echo "${params.BUILD}"
            }
        }
    }


//    stage("Push image in repo?") {
//     				script {
//					Boolean userInput = input(id: 'Proceed1', message: 'Promote build?')
//						echo 'userInput: ' + userInput
//
//					if(userInput == true) {
//						// do action
//					} else {
//						// not do action
//                 			 echo "Action was aborted."
//				}
//                 
//					}
//        }
        
        
        
    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
		 
        docker.withRegistry('https://registry.hub.docker.com', 'DockerHub') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}
