pipeline {
	 environment {
	  BUILDTIMESTAMP = "$BUILD_TIMESTAMP"
	  BUILD_HOME = "/opt/build/${COMPONENTNAME}/${BUILDTIMESTAMP}"
	  WORKSPACE_HOME = "${HOME}/workspace/tibco-bwce"
      MVNUSER = "tibco"
    }
    agent any
	stages {
	 	stage('Package') {
			steps {
                 //Create Package
                 sh ('source /home/jenkins/.bash_profile && cd ${WORKSPACE_HOME}/${COMPONENTNAME}/${REPOSITORYNAME}.application.parent && mvn -Dmaven.repo.local=/home/${MVNUSER}/.m2/repository clean initialize package -f pom.xml')
				
				//Build Enviornment
				 sh ('mkdir -p ${BUILD_HOME}')
				 sh ('cp ${WORKSPACE_HOME}/${COMPONENTNAME}/${REPOSITORYNAME}.application/target/*.ear ${BUILD_HOME}/')
				 script {
                    env.EARFILE = sh(script: 'cd ${BUILD_HOME} && ls *.ear', returnStdout: true).trim()
				  	sh ('cp /opt/docker/Dockerfile ${BUILD_HOME}/')
					sh ('cp /opt/docker/*.jar ${BUILD_HOME}/')
					sh ('cp /opt/docker/*.xslt ${BUILD_HOME}/')
					sh ('cp /opt/docker/cacerts ${BUILD_HOME}/')
				    sh ('sed -i "s/<EAR_FILE>/${EARFILE}/g" ${BUILD_HOME}/Dockerfile')
                 }

			   }
        }
		stage('build') {
		  	steps {
			     script {
			        env.BUILDTAG = sh(script: 'echo "1.0.0.${BUILDTIMESTAMP}"', returnStdout: true).trim()
				    //set up the docker config
				    sh('aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_REGISTRY}')
					// Build docker image
					sh('cd ${BUILD_HOME} && docker build --no-cache -f Dockerfile -t ${AWS_REGISTRY}/${REPOSITORYNAME}:${BUILDTAG} .')
					//Push the image to docker registry
					sh('docker push ${AWS_REGISTRY}/${REPOSITORYNAME}:${BUILDTAG}')
				}
            }
        }
    }
	post {
        success {
		   
            emailext body: """Component Name: ${COMPONENTNAME}, \nRepository Name: ${REPOSITORYNAME}, \nDeployment Name: ${DEPLOYMENTNAME}, \nBuild Timestamp: $BUILDTIMESTAMP """, recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: """Build Successfully Completed : ${JOB_NAME}: Build Number: ${BUILD_NUMBER} """
            }
		    
	    failure {
		   
            emailext body: """Component Name: ${COMPONENTNAME}, \nRepository Name: ${REPOSITORYNAME}, \nDeployment Name: ${DEPLOYMENTNAME}, \nBuild Timestamp: $BUILDTIMESTAMP """, recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: """Build failed : ${JOB_NAME}: Build Number ${BUILD_NUMBER} """
            }
    }
}






