# 🎯 Jenkins Setup - Complete Guide

## 🚀 Step 1: Jenkins Initial Setup

### A. Open Jenkins Dashboard
- **URL**: http://localhost:8081
- **Password**: `00de5ee1b4534086aeeb43df62ff6e89`

### B. Setup Wizard Steps:
1. **Unlock Jenkins**: Enter password above
2. **Install Plugins**: Select "Install suggested plugins"
3. **Create Admin User**:
   - Username: `admin`
   - Password: `admin123`
   - Full Name: `Admin User`
   - Email: `admin@flask.com`
4. **Instance Configuration**: Keep default URL
5. **Start using Jenkins**

---

## 🐳 Step 2: Docker Hub Integration

### A. Create Docker Hub Access Token
1. Go to **hub.docker.com**
2. Login to your account
3. Go to **Account Settings** → **Security**
4. Click **New Access Token**
5. Name: `Jenkins-Flask-App`
6. Copy the token (save it!)

### B. Add Credentials in Jenkins
1. **Manage Jenkins** → **Credentials**
2. **System** → **Global credentials**
3. **Add Credentials**
4. Select **Username with password**
5. Fill details:
   ```
   ID: docker-hub-credentials
   Username: [Your Docker Hub Username]
   Password: [Your Access Token]
   Description: Docker Hub Access Token
   ```
6. **Create**

---

## 🔧 Step 3: Install Required Plugins

### A. Go to Plugin Manager
1. **Manage Jenkins** → **Plugins**
2. **Available plugins** tab

### B. Install These Plugins:
- ✅ **Docker Pipeline**
- ✅ **GitHub Integration Plugin**
- ✅ **Pipeline Stage View**
- ✅ **Blue Ocean** (optional, for better UI)

### C. Restart Jenkins
- Check "Restart Jenkins when installation is complete"

---

## 📝 Step 4: Create Pipeline Job

### A. Create New Job
1. **New Item**
2. **Item name**: `flask-docker-pipeline`
3. **Pipeline** → **OK**

### B. Configure Pipeline
1. **Description**: `Flask App CI/CD to Docker Hub`
2. **Build Triggers**: 
   - ☑️ **GitHub hook trigger for GITScm polling**
3. **Pipeline Definition**: **Pipeline script from SCM**
4. **SCM**: **Git**
5. **Repository URL**: `https://github.com/AnujGupta1606/flask-dockerhub-deploy.git`
6. **Branch**: `*/main`
7. **Script Path**: `Jenkinsfile`
8. **Save**

---

## ⚡ Step 5: Test Your Pipeline

### A. Manual Build
1. Go to `flask-docker-pipeline` job
2. Click **Build Now**
3. Watch **Console Output**

### B. Expected Pipeline Stages:
```
1. 🔄 Checkout - Git repository clone
2. 🧪 Test Application - Python tests
3. 🐳 Build Docker Image - Container creation
4. 📤 Push to Docker Hub - Image publishing
5. 🚀 Deploy - Container deployment
6. 🧹 Cleanup - Old container removal
```

---

## 🌍 Step 6: GitHub Webhook (Auto-trigger)

### A. In GitHub Repository
1. Go to **Settings** → **Webhooks**
2. **Add webhook**
3. **Payload URL**: `http://your-public-ip:8081/github-webhook/`
4. **Content type**: `application/json`
5. **Events**: Just the push event
6. **Add webhook**

---

## 📊 Step 7: Monitor & Verify

### A. Check Build Status
- Green ✅ = Success
- Red ❌ = Failed (check console output)

### B. Verify Docker Hub
1. Go to hub.docker.com
2. Check your repositories
3. Should see `flask-app` image

### C. Test Deployed App
- Local: http://localhost:5000
- Container info: http://localhost:5000/api/info

---

## 🛠️ Quick Commands for Testing

```bash
# Check Jenkins logs
docker logs jenkins-flask

# Check running containers
docker ps

# Test Flask app locally
curl http://localhost:5555/

# View Docker images
docker images | findstr flask

# Manual Docker build
docker build -t flask-app .

# Manual Docker run
docker run -d -p 5000:5000 flask-app
```

---

## 🎯 Success Checklist

- [ ] Jenkins accessible at http://localhost:8081
- [ ] Admin user created (admin/admin123)
- [ ] Docker Hub credentials added
- [ ] Required plugins installed
- [ ] Pipeline job created and configured
- [ ] First build successful
- [ ] Docker image pushed to Docker Hub
- [ ] Flask app deployed and accessible

---

## 🆘 Troubleshooting

### Common Issues:

**1. Build Failed - Docker Hub Push**
```
Solution: Check Docker Hub credentials
- Verify username/token in Jenkins credentials
- Ensure token has push permissions
```

**2. Pipeline Stuck at Test Stage**
```
Solution: Python environment issue
- Check Jenkinsfile test commands
- Verify requirements.txt
```

**3. Port Already in Use**
```
Solution: Use different port
- Modify Jenkinsfile deploy stage
- Change port from 5000 to 5001/5002
```

**4. GitHub Webhook Not Working**
```
Solution: Use manual builds for now
- Need public IP for webhooks
- Use ngrok for local testing
```

---

## 🎉 What You'll Get

After complete setup:
- ✅ **Automated CI/CD Pipeline**
- ✅ **Docker Hub Integration**
- ✅ **Automatic Testing**
- ✅ **Container Deployment**
- ✅ **Build Notifications**
- ✅ **Version Management**

**Ab Jenkins UI mein ja ke ye sab steps follow karo! Sab kuch ready hai!** 🚀
