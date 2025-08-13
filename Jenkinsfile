pipeline {
    agent any

    tools {
        maven 'Maven3'
    }

    environment {
        DOCKERHUB_USER = credentials('dockerhub-user')
        DOCKERHUB_PASS = credentials('dockerhub-pass')
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
                sh 'docker build -t $DOCKERHUB_USER/devops-mini-project:latest .'
            }
        }
        stage('Push to DockerHub') {
            steps {
                sh 'echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin'
                sh 'docker push $DOCKERHUB_USER/devops-mini-project:latest'
            }
        }
        stage('Deploy on EC2') {
            steps {
                sh 'docker rm -f devops-app || true'
                sh 'docker run -d --name devops-app -p 8080:8080 $DOCKERHUB_USER/devops-mini-project:latest'
            }
        }
    }
}
