@echo off
echo ====================================
echo Manual Docker Hub Deployment
echo ====================================
echo.

echo Step 1: Building Docker Image...
docker build -t flask-dockerhub-app .
if %errorlevel% neq 0 (
    echo ERROR: Docker build failed
    pause
    exit /b 1
)

echo.
echo Step 2: Testing Flask App...
docker run --rm -d -p 5555:5000 --name flask-test flask-dockerhub-app
timeout /t 10 /nobreak
curl http://localhost:5555/ 2>nul || echo "App test (manual check: http://localhost:5555)"
docker stop flask-test

echo.
echo Step 3: Docker Hub Login
set /p DOCKER_USERNAME="Enter Docker Hub Username: "
set /p DOCKER_PASSWORD="Enter Docker Hub Password/Token: "

echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin
if %errorlevel% neq 0 (
    echo ERROR: Docker Hub login failed
    pause
    exit /b 1
)

echo.
echo Step 4: Tagging and Pushing Image...
docker tag flask-dockerhub-app %DOCKER_USERNAME%/flask-dockerhub-app:latest
docker tag flask-dockerhub-app %DOCKER_USERNAME%/flask-dockerhub-app:v1.0

docker push %DOCKER_USERNAME%/flask-dockerhub-app:latest
docker push %DOCKER_USERNAME%/flask-dockerhub-app:v1.0

echo.
echo Step 5: Cleanup
docker logout
docker rmi flask-dockerhub-app
docker rmi %DOCKER_USERNAME%/flask-dockerhub-app:latest
docker rmi %DOCKER_USERNAME%/flask-dockerhub-app:v1.0

echo.
echo ====================================
echo ✅ Deployment Completed Successfully!
echo ====================================
echo.
echo Your Flask app is now available on Docker Hub:
echo https://hub.docker.com/r/%DOCKER_USERNAME%/flask-dockerhub-app
echo.
echo To run your app anywhere:
echo docker run -p 5000:5000 %DOCKER_USERNAME%/flask-dockerhub-app
echo.
pause
