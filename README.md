# Multi-Environment Web Application Deployment Pipeline

## 📋 Project Overview
A complete CI/CD pipeline demonstrating automated deployment of a containerized Flask web application across multiple environments (dev, staging, production) using GitLab CI/CD and self-hosted runners.

## 🏗️ Architecture
- **Application**: Python Flask web app
- **Containerization**: Docker
- **CI/CD Platform**: GitLab CI/CD
- **Deployment**: 4 VMs with dedicated GitLab Runners
  - VM1: Development + Build environment
  - VM2: Staging environment
  - VM3: Production environment
  - VM4: Backup development environment

## 🚀 Pipeline Stages

### 1. Build Stage
- Builds Docker image from source code
- Tags image with commit SHA and 'latest'
- Pushes to GitLab Container Registry
- **Runs on**: VM1 (dev runner)

### 2. Test Stage
- Validates Python imports
- Runs basic application tests
- **Runs on**: VM1 (dev runner)

### 3. Deploy-Dev Stage
- Automatically deploys to development environment
- Runs smoke tests
- Accessible on port 8080
- **Runs on**: VM1 (dev runner)
- **Trigger**: Automatic on push to develop/main

### 4. Deploy-Staging Stage
- Manually approved deployment to staging
- Runs smoke tests
- Accessible on port 8081
- **Runs on**: VM2 (staging runner)
- **Trigger**: Manual approval required

### 5. Deploy-Production Stage
- Manually approved deployment to production
- Runs smoke tests
- Accessible on port 8082
- **Runs on**: VM3 (production runner)
- **Trigger**: Manual approval required

## 🔧 Technologies Used
- **GitLab CI/CD**: Pipeline orchestration
- **Docker**: Containerization
- **Flask**: Web framework
- **Gunicorn**: WSGI server
- **Bash**: Deployment scripts
- **Python 3.11**: Application runtime

## 💡 Skills Demonstrated
- ✅ Multi-stage Docker builds with optimization
- ✅ GitLab CI/CD pipeline configuration
- ✅ Container registry management
- ✅ Environment-specific deployments
- ✅ Manual approval gates for production
- ✅ Automated smoke testing
- ✅ Self-hosted GitLab Runner setup
- ✅ Infrastructure as Code principles
- ✅ Shell scripting for automation
- ✅ Security best practices (non-root containers, health checks)

## 📊 Access Points
- **Development**: http://VM1-IP:8080
- **Staging**: http://VM2-IP:8081
- **Production**: http://VM3-IP:8082

## 🔄 Deployment Workflow
1. Developer pushes code to `develop` or `main` branch
2. Pipeline automatically builds and tests
3. Development deployment happens automatically
4. Team manually approves staging deployment
5. After staging validation, team manually approves production deployment

## 🛡️ Security Features
- Non-root container user
- Health check endpoints
- Automated smoke tests
- Manual approval gates for critical environments
- Container Registry authentication

## 📈 Future Enhancements
- Comprehensive unit/integration test suite
- Rollback mechanism
- Blue-green deployments
- Database integration
- Monitoring with Prometheus/Grafana
- Secrets management with HashiCorp Vault
- Slack/Email notifications

## 👤 Author
Created as a portfolio project demonstrating DevOps/SysAdmin capabilities for job applications.

## 📜 Certifications Referenced
- Red Hat Certified System Administrator (RHCSA)
- Red Hat Certified Engineer (RHCE) skills
- AWS Certified Cloud Practitioner
