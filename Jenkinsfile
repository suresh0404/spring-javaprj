pipeline {
    agent any

    tools {
        maven 'Maven3' // Make sure Maven3 is installed in Jenkins Global Tools
    }
    
    environment {
        DOCKERHUB = credentials('dockerhub-creds') // Username+Password in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/suresh0404/spring-javaprj.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKERHUB_USR/devops-mini-project:latest .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                sh 'echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin'
                sh 'docker push $DOCKERHUB_USR/devops-mini-project:latest'
            }
        }

        stage('Deploy on EC2') {
            steps {
                sh 'docker rm -f devops-app || true'
                sh 'docker run -d --name devops-app -p 9090:9090 $DOCKERHUB_USR/devops-mini-project:latest'
            }
        }
    }
}
