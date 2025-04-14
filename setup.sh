#!/bin/bash

# Exit if any command fails
set -e

# Define variables
APP_NAME="simple-time-service"
DOCKER_USERNAME="vivek6899"   # Change this
GIT_REPO_URL="https://github.com/vivektrivediii/devops-challenge-senior-particle41.git"  # Change this

# Create directory
mkdir -p $APP_NAME
cd $APP_NAME

# Write app.py
cat > app.py <<EOF
from flask import Flask, request, jsonify
from datetime import datetime
import socket

app = Flask(__name__)

@app.route("/", methods=["GET"])
def home():
    visitor_ip = request.remote_addr
    return jsonify({
        "timestamp": datetime.utcnow().isoformat() + "Z",
        "ip": visitor_ip
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF

# Write requirements.txt
cat > requirements.txt <<EOF
flask
EOF

# Dockerfile
cat > Dockerfile <<EOF
FROM python:3.9-slim

# Create non-root user
RUN useradd -m appuser

# Set workdir
WORKDIR /app

# Copy code
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

# Switch to non-root user
USER appuser

# Expose and run
EXPOSE 5000
CMD ["python", "app.py"]
EOF

# .dockerignore
cat > .dockerignore <<EOF
__pycache__
*.pyc
*.pyo
*.pyd
*.db
*.sqlite3
EOF

# README.md
cat > README.md <<EOF
# SimpleTimeService

This is a minimalist Flask web service that returns the current UTC timestamp and the client's IP address in JSON format.

## Endpoint

\`\`\`json
GET /
{
  "timestamp": "2025-04-14T12:00:00Z",
  "ip": "127.0.0.1"
}
\`\`\`

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- Optional: [Python 3](https://www.python.org/downloads/)

## Build and Run Locally

\`\`\`bash
docker build -t simple-time-service .
docker run -p 5000:5000 simple-time-service
\`\`\`

## Test

\`\`\`bash
curl http://localhost:5000/
\`\`\`

## Publish (optional)

Make sure you're logged in to Docker Hub:

\`\`\`bash
docker login
docker tag simple-time-service $DOCKER_USERNAME/simple-time-service:latest
docker push $DOCKER_USERNAME/simple-time-service:latest
\`\`\`

## Run From Docker Hub (optional)

\`\`\`bash
docker run -p 5000:5000 $DOCKER_USERNAME/simple-time-service:latest
\`\`\`

## Run as a Non-root User

The Dockerfile creates a non-root user \`appuser\` to run the application securely.
EOF

# # Git init
# git init
# git add .
# git commit -m "Initial commit: SimpleTimeService app with Docker support"

# # Uncomment below if you already created the repo
# # git remote add origin $GIT_REPO_URL
# git push -u origin main

echo "✅ SimpleTimeService setup complete."
echo "Now cd $APP_NAME and run: docker build -t simple-time-service . && docker run -p 5000:5000 simple-time-service"
