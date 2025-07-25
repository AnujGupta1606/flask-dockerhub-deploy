@echo off
cls
echo ===============================================
echo        JENKINS DOCKER HUB SETUP GUIDE
echo ===============================================
echo.

echo 🎯 STEP 1: JENKINS LOGIN
echo URL: http://localhost:8081
echo Password: 00de5ee1b4534086aeeb43df62ff6e89
echo.

echo 🎯 STEP 2: ADMIN USER SETUP
echo Username: admin
echo Password: admin123
echo Email: admin@flask.com
echo.

echo 🎯 STEP 3: DOCKER HUB CREDENTIALS
echo 1. Go to hub.docker.com
echo 2. Account Settings - Security
echo 3. Create New Access Token
echo 4. Copy the token
echo.
echo In Jenkins:
echo - Manage Jenkins - Credentials
echo - System - Global credentials
echo - Add Credentials
echo - ID: docker-hub-credentials
echo - Username: [Your Docker Hub Username]
echo - Password: [Your Access Token]
echo.

echo 🎯 STEP 4: CREATE PIPELINE
echo 1. New Item
echo 2. Name: flask-docker-pipeline
echo 3. Type: Pipeline
echo 4. Repository: https://github.com/AnujGupta1606/flask-dockerhub-deploy.git
echo 5. Branch: main
echo 6. Script Path: Jenkinsfile
echo.

echo 🎯 STEP 5: BUILD AND TEST
echo 1. Click Build Now
echo 2. Watch Console Output
echo 3. Check Docker Hub for your image
echo.

echo ===============================================
echo Current Status:
docker ps | findstr jenkins-flask
echo.
echo Flask App Status:
docker ps | findstr 5555
echo.

echo ===============================================
echo Next Steps:
echo 1. Open Jenkins: http://localhost:8081
echo 2. Follow setup guide in JENKINS_DOCKER_HUB_SETUP.md
echo 3. Create Docker Hub access token
echo 4. Configure Jenkins pipeline
echo 5. Run your first build!
echo ===============================================
pause
