@echo off
echo 🚀 Flask App Start kar rahe hain...

REM Stop any running container
docker stop my-flask-app >nul 2>&1
docker rm my-flask-app >nul 2>&1

REM Run app
echo 📱 App start ho raha hai...
docker run --rm -p 5002:5000 --name my-flask-app my-flask-app

echo 🎉 App start ho gaya!
echo 🌐 Browser mein jao: http://localhost:5002
