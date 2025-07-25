# Jenkins CI/CD Setup Guide

## 🚀 Complete Flask Docker Hub Deployment Setup

### Prerequisites ✅
- Docker Desktop running
- GitHub repository created: `flask-dockerhub-deploy`
- Docker Hub account ready

### 1. Start Jenkins Container

```bash
# Start Jenkins with persistent storage
docker run -d --name jenkins-flask -p 8081:8080 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts

# Wait for initialization (2-3 minutes)
# Then get initial admin password
docker exec jenkins-flask cat /var/jenkins_home/secrets/initialAdminPassword
```

### 2. Jenkins Initial Setup

1. **Access Jenkins**: Open http://localhost:8081
2. **Enter Admin Password**: Use the password from step 1
3. **Install Suggested Plugins**: Click "Install suggested plugins"
4. **Create Admin User**: 
   - Username: `admin`
   - Password: `admin123`
   - Email: `your-email@example.com`
5. **Jenkins URL**: Keep default `http://localhost:8081/`

### 3. Configure Docker Hub Credentials

1. Go to: **Manage Jenkins** → **Credentials** → **System** → **Global credentials**
2. Click **Add Credentials**
3. Select **Username with password**
4. **ID**: `docker-hub-credentials`
5. **Username**: Your Docker Hub username
6. **Password**: Your Docker Hub access token
7. **Description**: `Docker Hub Access`

### 4. Create Pipeline Job

1. **New Item** → Enter name: `flask-app-pipeline`
2. Select **Pipeline** → **OK**
3. **Pipeline Definition**: `Pipeline script from SCM`
4. **SCM**: Git
5. **Repository URL**: `https://github.com/yourusername/flask-dockerhub-deploy.git`
6. **Branch**: `*/main`
7. **Script Path**: `Jenkinsfile`
8. **Save**

### 5. Configure GitHub Integration (Optional)

1. **Manage Jenkins** → **Configure System**
2. **GitHub** section → **Add GitHub Server**
3. **API URL**: `https://api.github.com`
4. Add **GitHub Personal Access Token** in credentials

### 6. Run Your First Build

1. Go to `flask-app-pipeline`
2. Click **Build Now**
3. Watch the **Console Output**

## 📋 Current Project Status

### ✅ Completed Components:
- Flask application with health endpoints
- Dockerfile for containerization
- Jenkinsfile with complete CI/CD pipeline
- GitHub repository setup
- Docker Hub integration ready
- All scripts and configurations

### 🔧 Pipeline Stages:
1. **Checkout**: Git repository clone
2. **Test Application**: Python tests
3. **Build Docker Image**: Flask app containerization
4. **Push to Docker Hub**: Automated image publishing
5. **Deploy**: Container deployment
6. **Cleanup**: Workspace cleaning

### 📁 Project Structure:
```
flask-dockerhub-deploy/
├── app/
│   └── app.py              # Flask application
├── Dockerfile              # Container definition
├── Jenkinsfile            # Jenkins pipeline
├── requirements.txt       # Python dependencies
├── .github/workflows/     # GitHub Actions (alternative)
├── scripts/               # Deployment scripts
└── docs/                  # Documentation
```

### 🌐 Endpoints Available:
- `http://localhost:5000/` - Main application
- `http://localhost:5000/health` - Health check
- `http://localhost:5000/api/info` - Container information

### 🐳 Docker Commands:
```bash
# Build locally
docker build -t flask-app .

# Run locally
docker run -p 5000:5000 flask-app

# View running containers
docker ps
```

### 🚀 Deployment Options:
1. **Jenkins CI/CD** (Recommended) - Complete automation
2. **GitHub Actions** - Alternative CI/CD (already configured)
3. **Manual Docker** - Direct deployment

## 🔐 Security Notes:
- Store sensitive credentials in Jenkins Credentials Manager
- Use Docker Hub access tokens (not passwords)
- Enable GitHub webhook for automatic builds
- Configure proper user permissions

## 🆘 Troubleshooting:
- **Port conflicts**: Use different ports (5001, 5002, etc.)
- **Docker permissions**: Ensure Docker daemon running
- **Jenkins plugins**: Install Docker Pipeline plugin if missing
- **GitHub access**: Verify repository permissions

## 📞 Support:
Jenkins is ready at: http://localhost:8081
GitHub repo: https://github.com/yourusername/flask-dockerhub-deploy

Your complete Flask Docker Hub deployment setup is ready! 🎉
