#!/bin/bash

# Push Flask App to Docker Hub
# Make sure to run build-and-test.sh first

set -e

echo "🚀 Pushing to Docker Hub"
echo "======================="

# Check environment variables
if [ -z "$DOCKER_HUB_USERNAME" ]; then
    echo "❌ Please set DOCKER_HUB_USERNAME environment variable"
    echo "   export DOCKER_HUB_USERNAME='your-username'"
    exit 1
fi

IMAGE_NAME=${IMAGE_NAME:-"flask-dockerhub-app"}
IMAGE_TAG=${IMAGE_TAG:-"latest"}
FULL_IMAGE_NAME="$DOCKER_HUB_USERNAME/$IMAGE_NAME:$IMAGE_TAG"

echo "📤 Pushing image: $FULL_IMAGE_NAME"

# Login to Docker Hub (will prompt for password)
echo "🔐 Logging into Docker Hub..."
docker login

# Push the image
echo "📤 Pushing image to Docker Hub..."
docker push $FULL_IMAGE_NAME

# Also tag and push as latest if not already latest
if [ "$IMAGE_TAG" != "latest" ]; then
    echo "🏷️  Tagging as latest..."
    docker tag $FULL_IMAGE_NAME $DOCKER_HUB_USERNAME/$IMAGE_NAME:latest
    docker push $DOCKER_HUB_USERNAME/$IMAGE_NAME:latest
fi

echo ""
echo "🎉 Successfully pushed to Docker Hub!"
echo "📍 Image URL: https://hub.docker.com/r/$DOCKER_HUB_USERNAME/$IMAGE_NAME"
echo ""
echo "To pull and run from anywhere:"
echo "docker pull $FULL_IMAGE_NAME"
echo "docker run -p 5000:5000 $FULL_IMAGE_NAME"
