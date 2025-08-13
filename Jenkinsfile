pipeline {
    agent any
    tools {
        maven 'Maven3'
    }
    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/<username>/<repo>.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Docker Build & Push') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-cred', url: '']) {
                    sh 'docker build -t <dockerhub-username>/<image-name>:latest .'
                    sh 'docker push <dockerhub-username>/<image-name>:latest'
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker pull <dockerhub-username>/<image-name>:latest'
                sh 'docker stop myapp || true && docker rm myapp || true'
                sh 'docker run -d --name myapp -p 5000:5000 <dockerhub-username>/<image-name>:latest'
            }
        }
    }
}
