
#!/bin/bash

set -e

ENVIRONMENT=$1
VERSION=$2
CONTAINER_NAME="webapp-${ENVIRONMENT}"
IMAGE_NAME="${CI_REGISTRY_IMAGE}:${VERSION}"
PORT_MAPPING=""

# Set ports based on environment
case $ENVIRONMENT in
    dev)
        PORT_MAPPING="8080:5000"
        ;;
    staging)
        PORT_MAPPING="8081:5000"
        ;;
    production)
        PORT_MAPPING="8082:5000"
        ;;
    *)
        echo "Unknown environment: $ENVIRONMENT"
        exit 1
        ;;
esac

echo "========================================="
echo "Deploying to ${ENVIRONMENT} environment"
echo "Image: ${IMAGE_NAME}"
echo "Port: ${PORT_MAPPING}"
echo "========================================="

# Stop and remove existing container
echo "Stopping existing container..."
docker stop ${CONTAINER_NAME} 2>/dev/null || true
docker rm ${CONTAINER_NAME} 2>/dev/null || true

# Pull the latest image
echo "Pulling image..."
docker pull ${IMAGE_NAME}

# Run new container
echo "Starting new container..."
docker run -d \
    --name ${CONTAINER_NAME} \
    --restart unless-stopped \
    -p ${PORT_MAPPING} \
    -e ENVIRONMENT=${ENVIRONMENT} \
    -e APP_VERSION=${VERSION} \
    ${IMAGE_NAME}

echo "========================================="
echo "✅ Deployment complete!"
echo "Container: ${CONTAINER_NAME}"
echo "Access at: http://localhost:${PORT_MAPPING%%:*}"
echo "========================================="

