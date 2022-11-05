node {

//   ================================================================================================= 

    environment{
      registry = "jokercat2886/test-jenkins"
      registryCredential = 'DockerHub'
      docker_stop = '\$(docker ps -a -q)'
    }

//   ================================================================================================= 
//agent any //{label 'master'}
//   ================================================================================================= 
//stages {
    
//   =================================================================================================     

    stage('Cloning Git') {
      git url:'https://github.com/Demo2886/test_bootcamp.git', branch:'main'
    }
    
//   =================================================================================================  

//    stage ("Lint dockerfile") {
//        agent {
//            docker {
//                image 'hadolint/hadolint:latest-debian'
//                label 'master'
//                //image 'ghcr.io/hadolint/hadolint:latest-debian'
//             }
//        }
//        stage {
//            sh 'hadolint Dockerfile | tee -a hadolint_lint.txt'
//        }
//        post {
//            always {
//                archiveArtifacts 'hadolint_lint.txt'
//             }
//       }
//  }

//   ================================================================================================= 


    stage('Building image') {
        step{
            script {
                dockerImage = docker.build("$registry:$BUILD_NUMBER")
                dockerImage = docker.build("$registry:latest")
            }
        }
    }

//   ================================================================================================= 	

    stage('Test image') {
        
            sh "docker run -p 8001:8000 -d $registry:latest"
	          //sh "docker run -p 8002:8003 -d $registry:$BUILD_NUMBER"
	          sh "curl http://127.0.0.1:8001"
	          sh "docker stop $docker_stop"
       
    }

//   ================================================================================================= 

    stage('Push Image to repo') {
            script {
                docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                    dockerImage.push("${env.BUILD_NUMBER}")
                    dockerImage.push("latest")
                }	
            }    	
        }


//   ================================================================================================= 




    
//   ================================================================================================= 
    //}
    
//      k8s

        stage('Apply Kubernetes files') {
          withKubeConfig([credentialsId: 'kubernetes']) {
    	    sh 'kubectl get namespace | grep -q "^pre-prod " || kubectl create namespace pre-prod'
    		sh 'kubectl apply -f k8s_bom.yaml --namespace=pre-prod'
    		sleep 4
            sh 'kubectl get pods --namespace=pre-prod'
          }
        }
        
    
        stage('Deploy in prod') {
          
            script {
              catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE'){
                def depl = true
                try{
                  input("Deploy in prod?")
                }
                catch(err){
                  depl = false
                }
                try{
                  if(depl){
                  withKubeConfig([credentialsId: 'kubernetes']) {
                    sh 'kubectl get namespace | grep -q "^prod " || kubectl create namespace prod'
                    sh 'kubectl apply -f k8s_bom.yaml'
                    sleep 4
                    sh 'kubectl get pods --namespace=prod'
                    sh 'kubectl delete -f k8s_bom.yaml --namespace=pre-prod'
                    sh 'kubectl delete namespace pre-prod'
                  }
                  }
                }
                catch(Exception err){
                  error "Deployment filed"
                }
              }
            }
          
        }
		
	    
    
    
    	
}
