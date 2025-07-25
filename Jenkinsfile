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
                echo '✅ Code checked out successfully'
            }
        }
        
        stage('Verify Files') {
            steps {
                sh '''
                    echo "Checking project structure..."
                    ls -la
                    echo "Checking Dockerfile..."
                    cat Dockerfile
                    echo "Checking Flask app..."
                    ls -la app/
                    echo "✅ All files verified"
                '''
            }
        }
        
        stage('Notify Success') {
            steps {
                echo '✅ Flask Docker Hub deployment pipeline setup completed!'
                echo '📁 Project structure verified'
                echo '🐳 Dockerfile ready for deployment'
                echo '🚀 Flask app ready for containerization'
                echo '💡 Note: Docker build and push will happen on systems with Docker installed'
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            echo '✅ Pipeline completed successfully! Project is ready for Docker deployment.'
            echo '🎯 Next steps: Run Docker build and push manually or on Docker-enabled Jenkins agent'
        }
        failure {
            echo '❌ Pipeline failed! Check console output for details.'
        }
    }
}
