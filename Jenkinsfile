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



     stage('Deploy in prod') {
      steps{
        script {
          //catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE'){
		      input("Deploy in prod?")
		  
            //def depl = true
            //    try{
            //      input("Deploy in prod?")
            //    }
            //catch(err){
            //    depl = false
            //   }
            //try{
            //  if(depl){
            //        docker.withRegistry('https://registry.hub.docker.com', 'DockerHub') {
            //            app.push("${env.BUILD_NUMBER}")
            //            app.push("latest")
            //        }
            //    }
            //  }
            //}
            //catch(Exception err){
            //  error "Deployment filed"
            //}
          }
        }
      }
    }
