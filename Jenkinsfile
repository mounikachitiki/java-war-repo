pipeline {
    agent { label dagent }

    environment {
        AWS_REGION = 'us-east-1' // Change as per requirement
        ECR_REPO = '156041438538.dkr.ecr.us-east-1.amazonaws.com/mouni-repo'
        IMAGE_NAME = 'java-app-image'
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
                sh 'sudo docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push Image to AWS ECR') {
            steps {
                script {
                    sh '''
                    aws ecr get-login-password --region $AWS_REGION | sudo docker login --username AWS --password-stdin $ECR_REPO
                    sudo docker tag $IMAGE_NAME:latest $ECR_REPO/$IMAGE_NAME:latest
                    sudo docker push $ECR_REPO/$IMAGE_NAME:latest
                    '''
                }
            }
        }
    }
}
