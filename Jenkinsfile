pipeline {
    agent any

    environment {
        AWS_REGION     = "us-east-1"
        ECR_REPO       = "717279709688.dkr.ecr.us-east-1.amazonaws.com/eyego-repo"
        IMAGE_TAG      = "${BUILD_NUMBER}"
        CLUSTER_NAME   = "eyego-eks"
        DEPLOYMENT_YML = "k8s/deployment.yml"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/diaaqassem/Deploy-App-EKS-Terraform.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $ECR_REPO:$IMAGE_TAG ./app"
            }
        }

        stage('Login to AWS ECR') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-credentials']]) {
                    sh '''
                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
                    '''
                }
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh "docker push $ECR_REPO:$IMAGE_TAG"
            }
        }

        stage('Update Kubeconfig') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-credentials']]) {
                    sh "aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME"
                }
            }
        }

        stage('Update Deployment YAML with new image') {
            steps {
                sh 'sed -i "s|image: .*|image: ${ECR_REPO}:${IMAGE_TAG}|" ${DEPLOYMENT_YML}'
            }
        }

        stage('Deploy to EKS') {
            steps {
               withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-credentials']]){
                     sh "kubectl apply -f $DEPLOYMENT_YML"
        }
    }
        }
    }

    post {
        success {
            echo 'Deployment completed successfully!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}