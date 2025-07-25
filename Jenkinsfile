pipeline {
    agent any
    
    environment {
        IMAGE_NAME = "flask-dockerhub-app"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Test Application via Docker') {
            steps {
                script {
                    sh '''
                        echo "Testing Flask app using Docker..."
                        docker build -t test-flask-app .
                        docker run --rm test-flask-app python app/app.py --version
                        echo "✅ Flask app test passed via Docker"
                    '''
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                        sh '''
                            docker build -t ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG} .
                            docker tag ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:latest
                        '''
                    }
                }
            }
        }
        
        stage('Test Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                        sh '''
                            docker run --rm -d -p 5001:5000 --name test-container-${BUILD_NUMBER} ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}
                            sleep 15
                            curl -f http://localhost:5001/health || exit 1
                            docker stop test-container-${BUILD_NUMBER}
                            echo "✅ Docker image test passed"
                        '''
                    }
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                        sh '''
                            echo ${DOCKER_HUB_PASSWORD} | docker login -u ${DOCKER_HUB_USERNAME} --password-stdin
                            docker push ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}
                            docker push ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:latest
                            docker logout
                        '''
                    }
                }
            }
        }
        
        stage('Clean Up') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                        sh '''
                            docker rmi ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG} || true
                            docker rmi ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:latest || true
                            docker rmi test-flask-app || true
                            docker system prune -f
                        '''
                    }
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            echo '✅ Pipeline completed successfully! Docker image pushed to Docker Hub.'
        }
        failure {
            echo '❌ Pipeline failed! Check console output for details.'
        }
    }
}
