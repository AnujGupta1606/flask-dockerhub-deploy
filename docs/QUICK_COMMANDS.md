# Quick Commands Cheat Sheet 🚀

## 🏃‍♂️ One-Line Deploy

### Windows:
```powershell
# Set username and deploy in one go
$env:DOCKER_HUB_USERNAME="your-username"; docker build -t $env:DOCKER_HUB_USERNAME/flask-dockerhub-app:latest .; docker login; docker push $env:DOCKER_HUB_USERNAME/flask-dockerhub-app:latest
```

### Linux/Mac:
```bash
# Set username and deploy in one go
export DOCKER_HUB_USERNAME="your-username" && docker build -t $DOCKER_HUB_USERNAME/flask-dockerhub-app:latest . && docker login && docker push $DOCKER_HUB_USERNAME/flask-dockerhub-app:latest
```

## 🔧 Development Commands

```bash
# Local development with hot reload
docker-compose up --build

# Just Flask app (no nginx)
docker run -p 5000:5000 -v ${PWD}/app:/app your-username/flask-dockerhub-app

# View logs
docker-compose logs -f flask-app
```

## 🧪 Testing Commands

```bash
# Quick health check
curl http://localhost:5000/health

# JSON response test
curl -H "Accept: application/json" http://localhost:5000/

# Load test (if you have apache bench)
ab -n 100 -c 10 http://localhost:5000/
```

## 🐳 Docker Commands

```bash
# Build with custom tag
docker build -t your-username/flask-dockerhub-app:v1.0 .

# Run in background
docker run -d -p 5000:5000 --name flask-app your-username/flask-dockerhub-app

# Execute into running container
docker exec -it flask-app /bin/bash

# View container logs
docker logs flask-app

# Stop and remove
docker stop flask-app && docker rm flask-app
```

## 📊 Monitoring Commands

```bash
# Container stats
docker stats flask-app

# Container info
docker inspect flask-app

# Image layers
docker history your-username/flask-dockerhub-app
```

## 🧹 Cleanup Commands

```bash
# Remove all stopped containers
docker container prune

# Remove unused images
docker image prune

# Remove everything unused
docker system prune -a

# Remove specific image
docker rmi your-username/flask-dockerhub-app:latest
```

## 🚀 CI/CD Commands

```bash
# Trigger GitHub Actions (push to main)
git add . && git commit -m "Deploy to Docker Hub" && git push origin main

# Check GitHub Actions status
# Visit: https://github.com/your-username/your-repo/actions

# Manual Jenkins trigger (if using Jenkins)
curl -X POST http://jenkins-server/job/flask-app/build
```

## 🌐 Deploy Anywhere

```bash
# AWS ECS
aws ecs run-task --task-definition flask-app

# Google Cloud Run
gcloud run deploy --image your-username/flask-dockerhub-app:latest

# Azure Container Instances
az container create --image your-username/flask-dockerhub-app:latest

# Kubernetes
kubectl create deployment flask-app --image=your-username/flask-dockerhub-app:latest
```

## 🔍 Debug Commands

```bash
# Check if Docker is running
docker version

# Check available ports
netstat -tlnp | grep :5000

# Test without Docker
cd app && python app.py

# Check image exists on Docker Hub
docker search your-username/flask-dockerhub-app
```

## 📋 Copy-Paste Ready Setup

```bash
# Complete setup in 4 commands
git clone your-repo-url
cd flask-dockerhub-deploy
export DOCKER_HUB_USERNAME="your-username"  # Change this!
docker-compose up --build
```

## 🎯 Production Deploy

```bash
# Production build (no debug)
docker build --build-arg FLASK_DEBUG=0 -t your-username/flask-dockerhub-app:prod .

# Production run (restart always)
docker run -d --restart=always -p 80:5000 your-username/flask-dockerhub-app:prod
```

## 📱 Mobile/Remote Access

```bash
# Find your local IP
ipconfig getifaddr en0  # Mac
hostname -I | cut -d' ' -f1  # Linux
ipconfig | findstr IPv4  # Windows

# Run accessible from network
docker run -p 0.0.0.0:5000:5000 your-username/flask-dockerhub-app
# Access from: http://YOUR_IP:5000
```

---

**💡 Pro Tip:** Save these commands in your favorite note-taking app for quick access!
