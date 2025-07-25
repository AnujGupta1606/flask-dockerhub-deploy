@echo off
REM Push Flask App to Docker Hub - Windows
REM Make sure to run build-and-test.bat first

echo 🚀 Pushing to Docker Hub
echo =======================

REM Check environment variables
if "%DOCKER_HUB_USERNAME%"=="" (
    echo ❌ Please set DOCKER_HUB_USERNAME environment variable
    echo    set DOCKER_HUB_USERNAME=your-username
    exit /b 1
)

if "%IMAGE_NAME%"=="" set IMAGE_NAME=flask-dockerhub-app
if "%IMAGE_TAG%"=="" set IMAGE_TAG=latest
set FULL_IMAGE_NAME=%DOCKER_HUB_USERNAME%/%IMAGE_NAME%:%IMAGE_TAG%

echo 📤 Pushing image: %FULL_IMAGE_NAME%

REM Login to Docker Hub (will prompt for password)
echo 🔐 Logging into Docker Hub...
docker login
if %ERRORLEVEL% neq 0 (
    echo ❌ Docker login failed!
    exit /b 1
)

REM Push the image
echo 📤 Pushing image to Docker Hub...
docker push %FULL_IMAGE_NAME%
if %ERRORLEVEL% neq 0 (
    echo ❌ Docker push failed!
    exit /b 1
)

REM Also tag and push as latest if not already latest
if not "%IMAGE_TAG%"=="latest" (
    echo 🏷️  Tagging as latest...
    docker tag %FULL_IMAGE_NAME% %DOCKER_HUB_USERNAME%/%IMAGE_NAME%:latest
    docker push %DOCKER_HUB_USERNAME%/%IMAGE_NAME%:latest
)

echo.
echo 🎉 Successfully pushed to Docker Hub!
echo 📍 Image URL: https://hub.docker.com/r/%DOCKER_HUB_USERNAME%/%IMAGE_NAME%
echo.
echo To pull and run from anywhere:
echo docker pull %FULL_IMAGE_NAME%
echo docker run -p 5000:5000 %FULL_IMAGE_NAME%
