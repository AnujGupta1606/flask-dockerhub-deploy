# Flask Docker Hub Deployment 🚀

Complete setup for deploying Flask app to Docker Hub with CI/CD automation.

## ✅ What's Included

- **Flask App** - Simple REST API with health checks
- **Docker Setup** - Multi-stage build with health checks
- **Docker Compose** - Local development with Nginx
- **GitHub Actions** - Automated CI/CD pipeline
- **Jenkins Pipeline** - Enterprise CI/CD setup
- **Simple Scripts** - Copy-paste ready commands
- **Zero Laptop Storage** - Everything runs in cloud!

## 🚀 Quick Start

### 1. Setup Docker Hub Account
```bash
# Create free account at https://hub.docker.com
# Create access token in Security settings
```

### 2. Local Development
```bash
# Clone and navigate
git clone <your-repo-url>
cd flask-dockerhub-deploy

# Run with Docker Compose
docker-compose up --build

# Test the app
curl http://localhost:5000
curl http://localhost:5000/health
```

### 3. Build and Push to Docker Hub

#### Windows PowerShell:
```powershell
# Set your Docker Hub username
$env:DOCKER_HUB_USERNAME = "your-username"

# Build and test
.\scripts\build-and-test.bat

# Push to Docker Hub
.\scripts\push-to-dockerhub.bat
```

#### Linux/Mac:
```bash
# Set your Docker Hub username
export DOCKER_HUB_USERNAME="your-username"

# Make scripts executable
chmod +x scripts/*.sh

# Build and test
./scripts/build-and-test.sh

# Push to Docker Hub
./scripts/push-to-dockerhub.sh
```

### 4. Manual Docker Commands
```bash
# Build
docker build -t your-username/flask-dockerhub-app:latest .

# Test locally
docker run -p 5000:5000 your-username/flask-dockerhub-app:latest

# Push to Docker Hub
docker login
docker push your-username/flask-dockerhub-app:latest
```

## 🔄 CI/CD Setup

### GitHub Actions (Automatic)

1. **Add Secrets** in GitHub repo settings:
   - `DOCKER_HUB_USERNAME`: Your Docker Hub username
   - `DOCKER_HUB_TOKEN`: Your Docker Hub access token

2. **Push to GitHub** - Pipeline runs automatically!

3. **Check Actions** tab for build status

### Jenkins Setup

1. **Install Jenkins** with Docker plugin
2. **Add Credentials**:
   - ID: `docker-hub-credentials`
   - Username: Your Docker Hub username
   - Password: Your Docker Hub token
3. **Create Pipeline** job pointing to this repo
4. **Run Build** - Automatic Docker Hub deployment!

## 📁 Project Structure

```
flask-dockerhub-deploy/
├── app/
│   └── app.py              # Flask application
├── scripts/
│   ├── build-and-test.sh   # Linux/Mac build script
│   ├── build-and-test.bat  # Windows build script
│   ├── push-to-dockerhub.sh # Linux/Mac push script
│   └── push-to-dockerhub.bat # Windows push script
├── .github/workflows/
│   └── docker-hub-ci-cd.yml # GitHub Actions pipeline
├── docs/
│   └── README.md           # This file
├── Dockerfile              # Container definition
├── docker-compose.yml      # Local development setup
├── Jenkinsfile            # Jenkins pipeline
├── requirements.txt       # Python dependencies
├── nginx.conf             # Nginx configuration
├── .env.example          # Environment variables template
├── .gitignore            # Git ignore rules
└── .dockerignore         # Docker ignore rules
```

## 🧪 Testing

### Local Testing
```bash
# Test Flask app directly
cd app
python app.py

# Test with curl
curl http://localhost:5000
curl http://localhost:5000/health
```

### Docker Testing
```bash
# Build and run
docker build -t flask-test .
docker run -p 5000:5000 flask-test

# Health check
curl http://localhost:5000/health
```

## 🛠️ Customization

### Environment Variables
```bash
# Copy and edit environment file
cp .env.example .env

# Set your values
DOCKER_HUB_USERNAME=your-username
IMAGE_NAME=your-app-name
IMAGE_TAG=v1.0.0
```

### Adding Dependencies
```bash
# Edit requirements.txt
echo "new-package==1.0.0" >> requirements.txt

# Rebuild image
docker build -t your-username/flask-dockerhub-app:latest .
```

### Production Configuration
```python
# Edit app/app.py for production
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
```

## 🚀 Deployment Options

### 1. Pull from Docker Hub Anywhere
```bash
# Pull and run from any machine
docker pull your-username/flask-dockerhub-app:latest
docker run -p 5000:5000 your-username/flask-dockerhub-app:latest
```

### 2. Cloud Platforms

#### AWS ECS
```bash
# Use the Docker Hub image in ECS task definition
your-username/flask-dockerhub-app:latest
```

#### Google Cloud Run
```bash
# Deploy from Docker Hub
gcloud run deploy --image=your-username/flask-dockerhub-app:latest
```

#### Azure Container Instances
```bash
# Deploy from Docker Hub
az container create --image your-username/flask-dockerhub-app:latest
```

### 3. Kubernetes
```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-app
spec:
  containers:
  - name: flask-app
    image: your-username/flask-dockerhub-app:latest
    ports:
    - containerPort: 5000
```

## 🔒 Security Best Practices

1. **Use Multi-stage builds** (already implemented)
2. **Scan for vulnerabilities** (Trivy scan in CI/CD)
3. **Non-root user** in container
4. **Environment variables** for secrets
5. **Health checks** for monitoring

## 📊 Monitoring

### Health Endpoint
```bash
# Check app health
curl http://your-app-url/health

# Response: {"status": "healthy"}
```

### Docker Health Check
```bash
# Built-in Docker health check
docker ps # Shows health status
```

## 🐛 Troubleshooting

### Common Issues

1. **Docker login fails**
   ```bash
   # Use access token instead of password
   docker login -u username -p access_token
   ```

2. **Port already in use**
   ```bash
   # Change port in docker run
   docker run -p 5001:5000 your-image
   ```

3. **Permission denied**
   ```bash
   # Make scripts executable (Linux/Mac)
   chmod +x scripts/*.sh
   ```

4. **Image not found**
   ```bash
   # Check if image exists
   docker images | grep flask-dockerhub-app
   ```

### Getting Help

1. **Check logs**
   ```bash
   docker logs container-name
   ```

2. **Debug container**
   ```bash
   docker run -it your-image /bin/bash
   ```

3. **Check GitHub Actions** logs in repo Actions tab

## 📈 Next Steps

1. **Add database** (PostgreSQL, MongoDB)
2. **Add caching** (Redis)
3. **Add monitoring** (Prometheus, Grafana)
4. **Add logging** (ELK stack)
5. **Add SSL/TLS** (Let's Encrypt)
6. **Add load balancing** (Multiple instances)

## 🎉 Success!

Your Flask app is now:
- ✅ Containerized with Docker
- ✅ Available on Docker Hub
- ✅ Automated with CI/CD
- ✅ Ready for cloud deployment
- ✅ Zero laptop storage used!

## 📞 Support

Need help? Check:
- GitHub Issues for this repo
- Docker Hub documentation
- Flask documentation
- CI/CD platform docs (GitHub Actions, Jenkins)

Happy coding! 🚀
