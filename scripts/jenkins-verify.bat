@echo off
echo ====================================
echo Jenkins Setup Verification
echo ====================================
echo.

echo Checking Jenkins container status...
docker ps | findstr jenkins-flask
if %errorlevel% neq 0 (
    echo ERROR: Jenkins container not running
    exit /b 1
)

echo.
echo Jenkins Admin Password:
echo 00de5ee1b4534086aeeb43df62ff6e89
echo.

echo Jenkins URL: http://localhost:8081
echo.

echo ====================================
echo Setup Steps:
echo ====================================
echo 1. Open Jenkins: http://localhost:8081
echo 2. Enter password: 00de5ee1b4534086aeeb43df62ff6e89
echo 3. Install suggested plugins
echo 4. Create admin user (admin/admin123)
echo 5. Add Docker Hub credentials
echo 6. Create pipeline job
echo.

echo ====================================
echo Flask App Status:
echo ====================================
docker ps | findstr 5555
if %errorlevel% equ 0 (
    echo ✅ Flask app running on port 5555
    echo Test: http://localhost:5555
) else (
    echo ❌ Flask app not running
)

echo.
echo ====================================
echo Docker Hub Setup Reminder:
echo ====================================
echo 1. Get Docker Hub access token
echo 2. Add to Jenkins credentials
echo 3. ID: docker-hub-credentials
echo 4. Username: your-dockerhub-username
echo 5. Password: your-access-token
echo.

echo Check JENKINS_COMPLETE_SETUP.md for detailed steps
pause
