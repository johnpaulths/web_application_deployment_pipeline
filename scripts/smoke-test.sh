#!/bin/bash

set -e

ENVIRONMENT=$1
PORT=$2
MAX_RETRIES=30
RETRY_INTERVAL=2

echo "Running smoke tests for ${ENVIRONMENT} on port ${PORT}..."

# Wait for application to be ready
for i in $(seq 1 $MAX_RETRIES); do
    if curl -f -s http://localhost:${PORT}/health > /dev/null; then
        echo "✓ Health check passed"
        break
    fi
    
    if [ $i -eq $MAX_RETRIES ]; then
        echo "✗ Health check failed after ${MAX_RETRIES} attempts"
        exit 1
    fi
    
    echo "Waiting for application to start (attempt $i/$MAX_RETRIES)..."
    sleep $RETRY_INTERVAL
done

# Test main page
if curl -f -s http://localhost:${PORT}/ | grep -q "${ENVIRONMENT}"; then
    echo "✓ Main page is displaying correct environment"
else
    echo "✗ Main page test failed"
    exit 1
fi

# Check if correct version is displayed
if curl -f -s http://localhost:${PORT}/ | grep -q "${CI_COMMIT_SHORT_SHA}"; then
    echo "✓ Version information is correct"
else
    echo "✗ Version check failed"
    exit 1
fi

echo "All smoke tests passed for ${ENVIRONMENT}! ✓"
