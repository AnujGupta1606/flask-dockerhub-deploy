# Flask Docker App 🚀

Bahut simple Flask app jo Docker mein run hoti hai!

## 🎯 Kya Chahiye

- Docker install hona chahiye
- Bas itna hi!

## 🚀 Kaise Chalaye

### Option 1: Simple Scripts
```cmd
# Build aur test
simple-build.bat

# App run karo
simple-run.bat
```

### Option 2: Manual Commands
```cmd
# Build
docker build -t my-flask-app .

# Run
docker run -p 5000:5000 my-flask-app
```

## 🌐 Test Karo

Browser mein jao: http://localhost:5000

Endpoints:
- `/` - Main page
- `/health` - Health check
- `/api/info` - App info

## 🐳 Docker Hub Par Push

```cmd
# Pehle Docker Hub account banao
# Phir login karo
docker login

# Tag karo
docker tag my-flask-app your-username/my-flask-app

# Push karo
docker push your-username/my-flask-app
```

## 🎉 Ho Gaya!

Bas itna hi! Super simple setup 😊
