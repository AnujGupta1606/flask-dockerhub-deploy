@echo off
echo 🚀 Flask Docker Build aur Test

REM Docker check
docker --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ❌ Docker install nahi hai!
    exit /b 1
)

REM Build image
echo 📦 Docker image build kar rahe hain...
docker build -t my-flask-app .

if %ERRORLEVEL% neq 0 (
    echo ❌ Build fail ho gaya!
    exit /b 1
)

echo ✅ Build successful!

REM Test run
echo 🧪 App test kar rahe hain...
docker run --rm -d -p 5002:5000 --name flask-test my-flask-app

REM Wait
timeout /t 5 /nobreak >nul

REM Test health
echo 🔍 Health check...
curl -s http://localhost:5002/health >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ❌ Health check fail!
    docker stop flask-test >nul 2>&1
    exit /b 1
)

echo ✅ Health check pass!

REM Stop test
docker stop flask-test >nul 2>&1

echo 🎉 Sab kuch ready hai!
echo 📍 Localhost par dekhne ke liye: docker run -p 5002:5000 my-flask-app
echo 🌐 Browser mein jao: http://localhost:5002
