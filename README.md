# Automating Docker container deployment with Jenkins :whale:

## Overview

This project demonstrates a modernized CI/CD pipeline using **Jenkins**, **Docker**, and **Node.js**.

**Stack:**

- **Runtime**: Node.js 20 (Alpine)
- **Database**: MongoDB 6.0
- **Testing**: Mocha, Chai, Supertest
- **Infrastructure**: Docker Compose, Jenkins Pipeline

---

## Contents

1. [Prerequisites](#prerequisites)
2. [Local Development](#local-development)
3. [Jenkins Setup](#jenkins-setup)
4. [Pipeline Configuration](#pipeline-configuration)
5. [Troubleshooting](#troubleshooting)

---

## Prerequisites

- **Docker Desktop** (or Engine) installed.
- **Node.js** (v18+ recommended for local dev, though app runs in Docker).
- **Jenkins** (can be run locally or via container).

---

## Local Development

### 1. Setup

Runs the application stack (App + MongoDB) locally using Docker Compose. A reliable `run.sh` script is provided.

```bash
# Start the environment and seed the database
./run.sh
```

This will:

- Build the Node.js image.
- Start MongoDB (v6.0) and the Node app.
- Execute the seed script (`seeds/seed.js`) to populate the database.

Access the app at: [http://localhost:3000](http://localhost:3000)

### 2. Manual Commands

If you prefer running commands manually:

```bash
# Start services
docker-compose up -d --build

# Run tests
npm test
```

---

## Jenkins Setup

### 1. Installation

Ensure Jenkins is installed and running. If you are on Ubuntu, you can use the provided `setup.sh` to install Docker if it's not present.

### 2. Plugins

Install the following plugins via `Manage Jenkins > Plugins`:

- **Docker Pipeline**
- **Docker**
- **Pipeline**
- **Git**
- **NodeJS** (optional if running builds inside Docker agents)

### 3. Credentials

1. Go to `Manage Jenkins > Credentials`.
2. Add a new credential of type **Username with password**.
3. ID: `dockerhub` (matches the `Jenkinsfile`).
4. Enter your Docker Hub username and password.

---

## Pipeline Configuration

The `Jenkinsfile` defines the pipeline stages:

1. **Cloning Git**: Pulls code from the repository.
2. **Building Docker Image**: Builds the image tagged with the Jenkins `BUILD_NUMBER`.
3. **Deploying**: Pushes the image to your configured registry (default: `naistangz/docker_automation`).
4. **Cleanup**: Removes local artifacts to save space.

### Environment Variables

Edit the `environment` block in `Jenkinsfile` to match your updates:

```groovy
environment {
    registry = "your-dockerhub-username/repo-name"
    registryCredential = "dockerhub"
}
```

---

## Troubleshooting

### Docker Permission Denied

If Jenkins cannot access the Docker socket:

```bash
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```

### Database Connection Fails

Ensure the container name in `docker-compose.yml` matches `DB_HOST`.

- **Correct**: `mongodb://mongo:27017/posts`
- **Why**: Docker Compose uses service names as hostnames.
