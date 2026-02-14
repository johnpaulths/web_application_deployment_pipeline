#!/bin/bash

set -e

ENVIRONMENT=$1
PORT=$2
MAX_RETRIES=30
RETRY_INTERVAL=2

echo "========================================="
echo "Running smoke tests for ${ENVIRONMENT}"
echo "Port: ${PORT}"
echo "========================================="

# Wait for application to be ready
echo "Waiting for application to start..."
for i in $(seq 1 $MAX_RETRIES); do
    if curl -f -s http://localhost:${PORT}/health > /dev/null 2>&1; then
        echo "✅ Health check passed"
        break
    fi
    
    if [ $i -eq $MAX_RETRIES ]; then
        echo "❌ Health check failed after ${MAX_RETRIES} attempts"
        docker logs webapp-${ENVIRONMENT} || true
        exit 1
    fi
    
    echo "Attempt $i/$MAX_RETRIES - waiting..."
    sleep $RETRY_INTERVAL
done

# Test health endpoint returns correct environment (flexible JSON parsing)
HEALTH_RESPONSE=$(curl -s http://localhost:${PORT}/health)
if echo "$HEALTH_RESPONSE" | grep -q "\"environment\".*:.*\"${ENVIRONMENT}\""; then
    echo "✅ Health endpoint returns correct environment"
else
    echo "❌ Health endpoint test failed"
    echo "Response: $HEALTH_RESPONSE"
    exit 1
fi

# Test main page
if curl -f -s http://localhost:${PORT}/ | grep -qi "${ENVIRONMENT}"; then
    echo "✅ Main page displays correct environment"
else
    echo "❌ Main page test failed"
    exit 1
fi

# Check if version is displayed
if curl -f -s http://localhost:${PORT}/ | grep -q "Version"; then
    echo "✅ Version information is present"
else
    echo "❌ Version check failed"
    exit 1
fi

echo "========================================="
echo "✅ All smoke tests passed for ${ENVIRONMENT}!"
echo "========================================="

