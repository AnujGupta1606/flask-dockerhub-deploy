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
        
        stage('Test Application') {
            steps {
                script {
                    if (isUnix()) {
                        sh '''
                            python3 -m pip install --user -r requirements.txt
                            cd app
                            python3 -c "
import app
with app.app.test_client() as client:
    response = client.get('/')
    assert response.status_code == 200
    print('✅ Flask app test passed')
"
                        '''
                    } else {
                        bat '''
                            python -m pip install --user -r requirements.txt
                            cd app
                            python -c "import app; client = app.app.test_client(); response = client.get('/'); assert response.status_code == 200; print('✅ Flask app test passed')"
                        '''
                    }
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                        if (isUnix()) {
                            sh '''
                                docker build -t ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG} .
                                docker tag ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:latest
                            '''
                        } else {
                            bat '''
                                docker build -t %DOCKER_HUB_USERNAME%/%IMAGE_NAME%:%IMAGE_TAG% .
                                docker tag %DOCKER_HUB_USERNAME%/%IMAGE_NAME%:%IMAGE_TAG% %DOCKER_HUB_USERNAME%/%IMAGE_NAME%:latest
                            '''
                        }
                    }
                }
            }
        }
        
        stage('Test Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                        if (isUnix()) {
                            sh '''
                                docker run --rm -d -p 5001:5000 --name test-container-${BUILD_NUMBER} ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}
                                sleep 15
                                curl -f http://localhost:5001/health || exit 1
                                docker stop test-container-${BUILD_NUMBER}
                                echo "✅ Docker image test passed"
                            '''
                        } else {
                            bat '''
                                docker run --rm -d -p 5001:5000 --name test-container-%BUILD_NUMBER% %DOCKER_HUB_USERNAME%/%IMAGE_NAME%:%IMAGE_TAG%
                                timeout /t 15 /nobreak
                                curl -f http://localhost:5001/health
                                docker stop test-container-%BUILD_NUMBER%
                                echo ✅ Docker image test passed
                            '''
                        }
                    }
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                        if (isUnix()) {
                            sh '''
                                echo ${DOCKER_HUB_PASSWORD} | docker login -u ${DOCKER_HUB_USERNAME} --password-stdin
                                docker push ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}
                                docker push ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:latest
                                docker logout
                            '''
                        } else {
                            bat '''
                                echo %DOCKER_HUB_PASSWORD% | docker login -u %DOCKER_HUB_USERNAME% --password-stdin
                                docker push %DOCKER_HUB_USERNAME%/%IMAGE_NAME%:%IMAGE_TAG%
                                docker push %DOCKER_HUB_USERNAME%/%IMAGE_NAME%:latest
                                docker logout
                            '''
                        }
                    }
                }
            }
        }
        
        stage('Clean Up') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                        if (isUnix()) {
                            sh '''
                                docker rmi ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG} || true
                                docker rmi ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:latest || true
                                docker system prune -f
                            '''
                        } else {
                            bat '''
                                docker rmi %DOCKER_HUB_USERNAME%/%IMAGE_NAME%:%IMAGE_TAG% 2>nul || echo "Image cleanup skipped"
                                docker rmi %DOCKER_HUB_USERNAME%/%IMAGE_NAME%:latest 2>nul || echo "Latest image cleanup skipped"
                                docker system prune -f
                            '''
                        }
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
            echo '✅ Pipeline completed successfully!'
            emailext (
                subject: "✅ Jenkins Build Success: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "Build completed successfully. Docker image pushed to Docker Hub.",
                to: "${env.CHANGE_AUTHOR_EMAIL}"
            )
        }
        failure {
            echo '❌ Pipeline failed!'
            emailext (
                subject: "❌ Jenkins Build Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "Build failed. Please check the logs.",
                to: "${env.CHANGE_AUTHOR_EMAIL}"
            )
        }
    }
}
