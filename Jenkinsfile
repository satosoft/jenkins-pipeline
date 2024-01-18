pipeline {

	environment {
	registry = "thanhnguyencfa/jenkins-docker-test"
	DOCKER_PWD = "Docker@123"
	BUILD_NUMBER=10
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
		sh 'npm test'
		}
		}

		stage("Build & Push Docker image") {
		steps {
		sh 'docker image build -t $registry:$BUILD_NUMBER.'
		sh 'docker login -u thanhnguyencfa -p $DOCKER_PWD'
		sh 'docker image push $registry:$BUILD_NUMBER'
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

