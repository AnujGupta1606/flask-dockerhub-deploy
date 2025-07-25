@echo off
REM Flask App Docker Hub Deployment Scripts for Windows
REM Make sure to set these environment variables first:
REM set DOCKER_HUB_USERNAME=your-username
REM set IMAGE_NAME=flask-dockerhub-app

echo 🚀 Flask Docker Hub Deployment Helper
echo ======================================

REM Check if Docker is running
docker info >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ❌ Docker is not running. Please start Docker first.
    exit /b 1
)

REM Check environment variables
if "%DOCKER_HUB_USERNAME%"=="" (
    echo ❌ Please set DOCKER_HUB_USERNAME environment variable
    echo    set DOCKER_HUB_USERNAME=your-username
    exit /b 1
)

if "%IMAGE_NAME%"=="" set IMAGE_NAME=flask-dockerhub-app
if "%IMAGE_TAG%"=="" set IMAGE_TAG=latest
set FULL_IMAGE_NAME=%DOCKER_HUB_USERNAME%/%IMAGE_NAME%:%IMAGE_TAG%

echo 📦 Building Docker image: %FULL_IMAGE_NAME%

REM Build the Docker image
docker build -t %FULL_IMAGE_NAME% .
if %ERRORLEVEL% neq 0 (
    echo ❌ Docker build failed!
    exit /b 1
)

echo ✅ Docker image built successfully!

REM Test the image locally
echo 🧪 Testing the Docker image...
docker run --rm -d -p 5000:5000 --name flask-test %FULL_IMAGE_NAME%

REM Wait for the container to start
timeout /t 5 /nobreak >nul

REM Test health endpoint
curl -f http://localhost:5000/health >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ❌ Health check failed!
    docker stop flask-test
    exit /b 1
)
echo ✅ Health check passed!

REM Test main endpoint
curl -f http://localhost:5000/ >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ❌ Main endpoint test failed!
    docker stop flask-test
    exit /b 1
)
echo ✅ Main endpoint test passed!

REM Stop test container
docker stop flask-test

echo 🎉 All tests passed! Ready to push to Docker Hub.
echo.
echo Next steps:
echo 1. Login to Docker Hub: docker login
echo 2. Push image: docker push %FULL_IMAGE_NAME%
echo 3. Or run: scripts\push-to-dockerhub.bat
