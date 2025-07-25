# 🚀 Jenkins CI/CD Setup - Step by Step

## 📋 Jenkins Initial Admin Password
```
00de5ee1b4534086aeeb43df62ff6e89
```

## 🎯 Complete Jenkins Setup Process

### Step 1: Access Jenkins
1. Open: **http://localhost:8081**
2. Enter password: `00de5ee1b4534086aeeb43df62ff6e89`
3. Click **Continue**

### Step 2: Install Plugins
1. Select **"Install suggested plugins"**
2. Wait for installation to complete (2-3 minutes)

### Step 3: Create Admin User
1. **Username**: `admin`
2. **Password**: `admin123`
3. **Full Name**: `Flask Admin`
4. **Email**: `admin@example.com`
5. Click **Save and Continue**

### Step 4: Instance Configuration
1. **Jenkins URL**: Keep default `http://localhost:8081/`
2. Click **Save and Finish**
3. Click **Start using Jenkins**

### Step 5: Configure Docker Hub Credentials
1. Go to **Manage Jenkins** → **Credentials**
2. Click **System** → **Global credentials (unrestricted)**
3. Click **Add Credentials**
4. Select **Username with password**
5. Fill details:
   - **ID**: `docker-hub-credentials`
   - **Username**: Your Docker Hub username
   - **Password**: Your Docker Hub access token
   - **Description**: `Docker Hub Access Token`
6. Click **Create**

### Step 6: Install Required Plugins
1. Go to **Manage Jenkins** → **Plugins**
2. Go to **Available plugins**
3. Search and install:
   - **Docker Pipeline**
   - **GitHub Integration**
   - **Pipeline Stage View**
4. Restart Jenkins when prompted

### Step 7: Create Pipeline Job
1. Click **New Item**
2. **Item name**: `flask-app-pipeline`
3. Select **Pipeline**
4. Click **OK**

### Step 8: Configure Pipeline
1. **Description**: `Flask Docker Hub CI/CD Pipeline`
2. **Build Triggers**: Check **GitHub hook trigger for GITScm polling**
3. **Pipeline Definition**: `Pipeline script from SCM`
4. **SCM**: Git
5. **Repository URL**: `https://github.com/AnujGupta1606/flask-dockerhub-deploy.git`
6. **Branch Specifier**: `*/main`
7. **Script Path**: `Jenkinsfile`
8. Click **Save**

### Step 9: Test Your Pipeline
1. Click **Build Now**
2. Watch **Console Output**
3. Pipeline should complete successfully

### Step 10: Configure GitHub Webhook (Optional)
1. Go to your GitHub repository
2. **Settings** → **Webhooks**
3. Click **Add webhook**
4. **Payload URL**: `http://localhost:8081/github-webhook/`
5. **Content type**: `application/json`
6. **Events**: `Just the push event`
7. Click **Add webhook**

## 🔧 Pipeline Stages Explained

Your Jenkinsfile contains these stages:

1. **Checkout**: Downloads code from GitHub
2. **Test Application**: Runs Python tests
3. **Build Docker Image**: Creates container image
4. **Push to Docker Hub**: Publishes image
5. **Deploy**: Starts new container
6. **Cleanup**: Removes old containers

## 📊 Current Setup Status

### ✅ Ready Components:
- Jenkins Server: `http://localhost:8081`
- Flask App: `http://localhost:5555`
- GitHub Repo: `flask-dockerhub-deploy`
- Jenkinsfile: Complete CI/CD pipeline
- Dockerfile: Container configuration

### 🎯 Next Steps After Setup:
1. Complete Jenkins setup wizard
2. Add Docker Hub credentials
3. Create pipeline job
4. Run first build
5. Monitor deployment

## 🆘 Troubleshooting

### Common Issues:
1. **Plugin Installation Failed**: Try again or install individually
2. **Docker Hub Push Failed**: Check credentials
3. **Build Failed**: Check console output for errors
4. **Port Conflict**: Use different port for Flask app

### Useful Commands:
```bash
# Check Jenkins logs
docker logs jenkins-flask

# Restart Jenkins
docker restart jenkins-flask

# Access Jenkins container
docker exec -it jenkins-flask bash

# Check running containers
docker ps
```

## 🎉 Success Indicators

✅ **Jenkins accessible at http://localhost:8081**
✅ **Admin user created successfully**
✅ **Docker Hub credentials configured**
✅ **Pipeline job created**
✅ **First build successful**
✅ **Flask app deployed automatically**

**Ab bas Jenkins setup complete karo aur tumhara CI/CD pipeline ready hai!** 🚀
