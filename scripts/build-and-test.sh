#!/bin/bash

# Flask App Docker Hub Deployment Scripts
# Make sure to set these environment variables first:
# export DOCKER_HUB_USERNAME="your-username"
# export IMAGE_NAME="flask-dockerhub-app"

set -e

echo "🚀 Flask Docker Hub Deployment Helper"
echo "======================================"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Check environment variables
if [ -z "$DOCKER_HUB_USERNAME" ]; then
    echo "❌ Please set DOCKER_HUB_USERNAME environment variable"
    echo "   export DOCKER_HUB_USERNAME='your-username'"
    exit 1
fi

IMAGE_NAME=${IMAGE_NAME:-"flask-dockerhub-app"}
IMAGE_TAG=${IMAGE_TAG:-"latest"}
FULL_IMAGE_NAME="$DOCKER_HUB_USERNAME/$IMAGE_NAME:$IMAGE_TAG"

echo "📦 Building Docker image: $FULL_IMAGE_NAME"

# Build the Docker image
docker build -t $FULL_IMAGE_NAME .

echo "✅ Docker image built successfully!"

# Test the image locally
echo "🧪 Testing the Docker image..."
docker run --rm -d -p 5000:5000 --name flask-test $FULL_IMAGE_NAME

# Wait for the container to start
sleep 5

# Test health endpoint
if curl -f http://localhost:5000/health > /dev/null 2>&1; then
    echo "✅ Health check passed!"
else
    echo "❌ Health check failed!"
    docker stop flask-test
    exit 1
fi

# Test main endpoint
if curl -f http://localhost:5000/ > /dev/null 2>&1; then
    echo "✅ Main endpoint test passed!"
else
    echo "❌ Main endpoint test failed!"
    docker stop flask-test
    exit 1
fi

# Stop test container
docker stop flask-test

echo "🎉 All tests passed! Ready to push to Docker Hub."
echo ""
echo "Next steps:"
echo "1. Login to Docker Hub: docker login"
echo "2. Push image: docker push $FULL_IMAGE_NAME"
echo "3. Or run: ./scripts/push-to-dockerhub.sh"
