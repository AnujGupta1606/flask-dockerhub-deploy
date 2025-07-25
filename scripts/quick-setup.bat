@echo off
echo ====================================
echo Flask Docker Hub Deployment Setup
echo ====================================
echo.

echo Checking Docker status...
docker --version
if %errorlevel% neq 0 (
    echo ERROR: Docker not found. Please install Docker Desktop.
    pause
    exit /b 1
)

echo.
echo Starting Jenkins container...
docker run -d --name jenkins-flask -p 8081:8080 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts

echo.
echo Waiting for Jenkins to initialize (30 seconds)...
timeout /t 30 /nobreak

echo.
echo ====================================
echo Jenkins Setup Instructions:
echo ====================================
echo 1. Open: http://localhost:8081
echo 2. Get admin password with: docker exec jenkins-flask cat /var/jenkins_home/secrets/initialAdminPassword
echo 3. Follow setup wizard
echo 4. Install suggested plugins
echo 5. Create admin user
echo.

echo ====================================
echo Flask App Test:
echo ====================================
echo Building Flask app...
docker build -t flask-app .

echo.
echo Starting Flask app on port 5555...
docker run -d --name flask-test -p 5555:5000 flask-app

echo.
echo Testing Flask app...
timeout /t 5 /nobreak
curl http://localhost:5555/ 2>nul || echo "Curl not available, open http://localhost:5555/ in browser"

echo.
echo ====================================
echo Setup Complete!
echo ====================================
echo Jenkins: http://localhost:8081
echo Flask App: http://localhost:5555
echo.
echo Check JENKINS_SETUP.md for detailed instructions
echo.
pause
