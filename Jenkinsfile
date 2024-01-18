pipeline {

	environment {
	registry = "thanhnguyencfa/jenkins-docker-test"
	DOCKER_PWD = "Docker@123"
	BUILD_NUMBER=30
	}

	agent {
	docker {
	image 'gnschenker/jenkins-node-sample'
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
		sh "docker image build -t thanhnguyencfa/jenkins-docker-test:20 ."
		sh "docker login -u thanhnguyencfa -p Docker@123"
		sh "docker image push thanhnguyencfa/jenkins-docker-test:20"
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

