pipeline {

	environment {
	registry = "satosoft/alpine-node-docker"
	DOCKER_PWD = "Docker@1209"
	BUILD_NUMBER=02
	}

	agent {
	docker {
	image 'satosoft/alpine-node-docker:01'
	args '-p 3000:3000'
	args '-w /app'
	args '-v /var/run/docker.sock:/var/run/docker.sock'
	}
	}

	options {
	skipStagesAfterUnstable()
	}

	stages {
		
		stage("Build"){
		steps {
		sh 'npm install'
		}
		}

		stage("Test"){
		steps {
	         script {
                    // Start the server in the background
                    def serverProcess = sh(script: 'node server.js &', returnStatus: true)

                    // Run tests
                    sh 'npm test'

                    // Stop the server
                    //sh "kill ${serverProcess}"
                }
			}
		}

		stage("Build & Push Docker image") {
		steps {
		sh "docker image build -t satosoft/alpine-node-docker:03 ."
		sh "docker login -u satosoft -p Docker@1209"
		sh "docker image push satosoft/alpine-node-docker:03"
		sh "docker image rm $registry:$BUILD_NUMBER"
		}
		}

		stage('Cleanup') {
		steps{
		sh './jenkins/scripts/cleanup.sh'
		}
		}
	}
}

