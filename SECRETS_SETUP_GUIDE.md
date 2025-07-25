# GitHub Secrets Setup - Complete Guide

## 🔗 Direct Links:

### GitHub Repository Settings:
https://github.com/AnujGupta1606/flask-dockerhub-deploy/settings/secrets/actions

### Docker Hub Token Page:
https://hub.docker.com/settings/security

---

## 📝 Step-by-Step Instructions:

### PART A: Docker Hub Setup

1. **Go to Docker Hub**
   - Visit: https://hub.docker.com
   - Click "Sign up" (if no account)
   - Or "Sign in" (if have account)

2. **Create Access Token**
   - Click profile icon (top-right)
   - Select "Account Settings"
   - Click "Security" (left sidebar)
   - Click "New Access Token"
   - Token Name: "flask-app-github-actions"
   - Permissions: Read, Write, Delete
   - Click "Generate"
   - **COPY THE TOKEN** (you won't see it again!)

### PART B: GitHub Secrets Setup

1. **Go to Repository Settings**
   - Visit: https://github.com/AnujGupta1606/flask-dockerhub-deploy
   - Click "Settings" tab (top menu)

2. **Navigate to Secrets**
   - Left sidebar → "Secrets and variables"
   - Click "Actions"

3. **Add First Secret**
   - Click "New repository secret"
   - Name: DOCKER_HUB_USERNAME
   - Secret: (your Docker Hub username)
   - Click "Add secret"

4. **Add Second Secret**
   - Click "New repository secret"
   - Name: DOCKER_HUB_TOKEN  
   - Secret: (paste the access token from Docker Hub)
   - Click "Add secret"

---

## ✅ Verification:

After adding secrets, you should see:
- DOCKER_HUB_USERNAME ✓
- DOCKER_HUB_TOKEN ✓

Both will show "Updated X seconds ago"

---

## 🚀 What Happens Next:

1. Push any change to repository
2. GitHub Actions will trigger automatically
3. Docker image will build
4. Image will push to Docker Hub
5. ✅ Automatic deployment complete!

---

## 🔍 Troubleshooting:

### If secrets not working:
1. Check spelling: DOCKER_HUB_USERNAME (exactly)
2. Check spelling: DOCKER_HUB_TOKEN (exactly)  
3. Regenerate Docker Hub token
4. Re-add secrets

### If Docker Hub login fails:
1. Make sure token has "Write" permissions
2. Username should be exact (case-sensitive)
3. Token should be fresh (not expired)

---

## 📞 Need Help?

Direct links to check:
- Repository secrets: https://github.com/AnujGupta1606/flask-dockerhub-deploy/settings/secrets/actions
- GitHub Actions: https://github.com/AnujGupta1606/flask-dockerhub-deploy/actions
- Docker Hub repos: https://hub.docker.com/repositories
