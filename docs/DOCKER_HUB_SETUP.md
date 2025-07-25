# Docker Hub Setup Guide 🐳

## Step 1: Create Docker Hub Account

1. Go to [hub.docker.com](https://hub.docker.com)
2. Click "Sign Up" and create free account
3. Verify your email address

## Step 2: Create Access Token

1. Go to **Account Settings** → **Security**
2. Click **New Access Token**
3. Name: `flask-app-deployment`
4. Permissions: **Read, Write, Delete**
5. **Copy the token** (you won't see it again!)

## Step 3: Set Environment Variables

### Windows PowerShell:
```powershell
$env:DOCKER_HUB_USERNAME = "your-username"
# Keep token secure - don't save in scripts!
```

### Linux/Mac:
```bash
export DOCKER_HUB_USERNAME="your-username"
# Keep token secure - don't save in scripts!
```

## Step 4: GitHub Secrets Setup

1. Go to your GitHub repo
2. **Settings** → **Secrets and Variables** → **Actions**
3. Add **New repository secret**:
   - Name: `DOCKER_HUB_USERNAME`
   - Value: `your-dockerhub-username`
4. Add another secret:
   - Name: `DOCKER_HUB_TOKEN`
   - Value: `your-access-token`

## Step 5: Test Local Build

```bash
# Build image
docker build -t your-username/flask-dockerhub-app:latest .

# Test locally
docker run -p 5000:5000 your-username/flask-dockerhub-app:latest

# Visit http://localhost:5000
```

## Step 6: Push to Docker Hub

```bash
# Login (will prompt for token)
docker login -u your-username

# Push image
docker push your-username/flask-dockerhub-app:latest
```

## Step 7: Verify on Docker Hub

1. Go to [hub.docker.com](https://hub.docker.com)
2. Check your repositories
3. You should see `flask-dockerhub-app`

## Step 8: Pull from Anywhere

```bash
# Pull and run from any machine
docker pull your-username/flask-dockerhub-app:latest
docker run -p 5000:5000 your-username/flask-dockerhub-app:latest
```

## 🎉 Success!

Your image is now public on Docker Hub and can be deployed anywhere!
