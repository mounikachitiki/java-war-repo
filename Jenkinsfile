pipeline {
    agent { label 'dockeragent' }

    environment {
        AWS_REGION = 'us-east-1' // Change as per requirement
        ECR_REPO = '156041438538.dkr.ecr.us-east-1.amazonaws.com/mouni-repo'
    
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/mounikachitiki/java-war-repo.git'
            }
        }

        stage('Build Java Application') {
            steps {
                sh 'mvn clean package -DskipTests' // Ensure Maven is installed on the agent
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'sudo docker build -t mouni-repo .'
            }
        }

        stage('Push Image to AWS ECR') {
            steps {
                script {
                    sh '''
                    aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 156041438538.dkr.ecr.us-east-1.amazonaws.com
                    sudo docker tag mouni-repo:latest 156041438538.dkr.ecr.us-east-1.amazonaws.com/mouni-repo:latest
                    sudo docker push 156041438538.dkr.ecr.us-east-1.amazonaws.com/mouni-repo:latest
                    '''
                }
            }
        }
    }
}
