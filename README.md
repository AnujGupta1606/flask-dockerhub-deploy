# 🚀 Flask Docker Hub Deployment

Simple Flask application with automated Docker Hub deployment pipeline.

## 📁 Project Structure

```
flask-dockerhub-deploy/
├── app/
│   └── app.py              # Flask application
├── .github/workflows/      # GitHub Actions CI/CD
├── scripts/
│   └── manual-docker-deploy.bat  # Manual deployment script
├── docs/                   # Documentation
├── Dockerfile              # Container configuration
├── Jenkinsfile            # Jenkins pipeline
├── requirements.txt       # Python dependencies
└── README.md              # This file
```

## 🎯 Quick Start

### Local Development
```bash
# Install dependencies
pip install -r requirements.txt

# Run Flask app
cd app && python app.py

# Access at http://localhost:5000
```

### Docker Deployment
```bash
# Build image
docker build -t flask-app .

# Run container
docker run -p 5000:5000 flask-app

# Manual Docker Hub deployment
./scripts/manual-docker-deploy.bat
```

## 🌐 Available Endpoints

- **Main App**: `http://localhost:5000/`
- **Health Check**: `http://localhost:5000/health`
- **Container Info**: `http://localhost:5000/api/info`

## 🚀 Deployment Options

### 1. Manual Deployment (Recommended)
```bash
./scripts/manual-docker-deploy.bat
```

### 2. GitHub Actions (Automatic)
- Push code changes to trigger CI/CD
- Automatic Docker Hub deployment

### 3. Jenkins Pipeline
- Basic verification pipeline
- File structure validation

## 🔧 Configuration

### Docker Hub Setup
1. Create Docker Hub account
2. Generate access token
3. Use in deployment script or GitHub secrets

### GitHub Actions
- Configure `DOCKER_HUB_USERNAME` secret
- Configure `DOCKER_HUB_TOKEN` secret

## 📋 Features

- ✅ Flask web application
- ✅ Docker containerization
- ✅ Health monitoring endpoints
- ✅ CI/CD pipeline ready
- ✅ Docker Hub integration
- ✅ Cross-platform deployment

## 🛠️ Development

```bash
# Local testing
python app/app.py

# Docker testing
docker build -t test-app .
docker run -p 5000:5000 test-app

# Access application
curl http://localhost:5000/
```

---

**Ready for production deployment!** 🎉
