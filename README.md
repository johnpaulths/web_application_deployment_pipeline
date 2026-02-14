# Multi-Environment Web Application Deployment Pipeline

## Overview
This project demonstrates a complete CI/CD pipeline for deploying a containerized Flask web application across multiple environments (dev, staging, production).

## Architecture
- **Application**: Python Flask web app
- **Containerization**: Docker
- **CI/CD**: GitLab CI/CD
- **Deployment**: Three VMs (dev, staging, production)

## Pipeline Stages
1. **Build**: Create Docker image and push to GitLab Container Registry
2. **Test**: Run unit tests
3. **Deploy-Dev**: Auto-deploy to development (port 8080)
4. **Deploy-Staging**: Manual deploy to staging (port 8081)
5. **Deploy-Production**: Manual deploy with approval to production (port 8082)

## Environments
- **Development**: http://VM1-IP:8080 (auto-deploy on develop/main branch)
- **Staging**: http://VM2-IP:8081 (manual approval required)
- **Production**: http://VM3-IP:8082 (manual approval required)

## Skills Demonstrated
- Multi-stage Docker builds
- GitLab CI/CD pipeline configuration
- Container registry management
- Environment-specific deployments
- Manual approval gates
- Automated smoke testing
- Environment variable management

## Local Development
```bash
# Build locally
docker build -t webapp:local .

# Run locally
docker run -p 5000:5000 -e ENVIRONMENT=local -e APP_VERSION=dev webapp:local
```

## Deployment Process
1. Push code to `develop` branch → auto-deploys to dev
2. Merge to `main` branch → triggers pipeline
3. Manually approve staging deployment
4. Test in staging
5. Manually approve production deployment

## Future Enhancements
- Add comprehensive unit/integration tests
- Implement rollback mechanism
- Add monitoring and logging (Prometheus/Grafana)
- Database integration
- Blue-green deployments
