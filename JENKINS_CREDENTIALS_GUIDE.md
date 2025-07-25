# 🎯 Jenkins Credentials - Step by Step Navigation

## 🔧 Exact Steps to Add Docker Hub Credentials

### Method 1: Through UI Navigation

1. **Jenkins Dashboard** → **Manage Jenkins**
2. **Credentials** (click karo)
3. **System** (blue link - click karo)
4. **Global credentials (unrestricted)** (click karo)
5. **Add Credentials** button dikh jayega

### Method 2: Direct URL
```
http://localhost:8081/credentials/store/system/domain/_/newCredentials
```

### Method 3: If Still Not Working - Check Plugins

If "Add Credentials" button nahi dikh raha:

1. **Manage Jenkins** → **Plugins**
2. **Installed plugins** tab
3. Search for **"Credentials"**
4. Make sure **"Credentials Plugin"** is installed
5. If not installed:
   - Go to **Available plugins**
   - Search **"Credentials"**
   - Install **"Credentials Plugin"**
   - Restart Jenkins

## 🐳 Docker Hub Credentials Details

When you find "Add Credentials" button:

### Fill These Details:
```
Kind: Username with password
Scope: Global
Username: [Your Docker Hub Username]
Password: [Your Docker Hub Access Token]
ID: docker-hub-credentials
Description: Docker Hub Access Token for Flask App
```

### Important Notes:
- **Username**: Your actual Docker Hub username
- **Password**: NOT your Docker Hub password, but ACCESS TOKEN
- **ID**: Must be exactly `docker-hub-credentials` (Jenkinsfile expects this)

## 🔑 How to Get Docker Hub Access Token

1. Go to **hub.docker.com**
2. Login with your account
3. Click your profile → **Account Settings**
4. **Security** tab
5. **Access Tokens** section
6. **New Access Token**
7. Name: `Jenkins-Flask-Pipeline`
8. Permissions: **Read, Write, Delete**
9. **Generate** → **Copy the token**

## 🚨 Common Issues & Solutions

### Issue 1: No Add Credentials Button
**Solution**: Install Credentials Plugin
```
Manage Jenkins → Plugins → Available → Search "Credentials" → Install
```

### Issue 2: Access Denied
**Solution**: Check Admin Permissions
```
Make sure you're logged in as admin user
```

### Issue 3: Plugin Missing
**Solution**: Install Required Plugins
```
- Credentials Plugin
- Credentials Binding Plugin  
- Plain Credentials Plugin
```

## 🎯 Quick Test After Adding Credentials

1. Go to **Dashboard**
2. **New Item** → Name: `test-docker-connection`
3. **Pipeline** → **OK**
4. **Pipeline Script**:
```groovy
pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
    }
    stages {
        stage('Test') {
            steps {
                script {
                    echo "Docker Hub Username: ${env.DOCKER_HUB_CREDENTIALS_USR}"
                    echo "Credentials loaded successfully!"
                }
            }
        }
    }
}
```
5. **Save** → **Build Now**

If this works, your credentials are properly configured!

## 🚀 Next Steps After Credentials Added

1. Install Docker Pipeline plugin
2. Create main Flask pipeline job
3. Configure GitHub repository
4. Run first build
5. Check Docker Hub for pushed image

**Pehle System → Global credentials par click karo, phir Add Credentials button mil jayega!** 🎯
