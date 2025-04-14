# SimpleTimeService

This is a minimalist Flask web service that returns the current UTC timestamp and the client's IP address in JSON format.

## Endpoint

```json
GET /
{
  "timestamp": "2025-04-14T12:00:00Z",
  "ip": "127.0.0.1"
}
```

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- Optional: [Python 3](https://www.python.org/downloads/)

## Build and Run Locally

```bash
docker build -t simple-time-service .
docker run -p 5000:5000 simple-time-service
# docker run -p 80:5000 vivek6899/simple-time-service    if you want o run on http port 80
```

## Test

```bash
curl http://localhost:5000/
```

## Publish (optional)

Make sure you're logged in to Docker Hub:

```bash
docker login
docker tag simple-time-service vivek6899/simple-time-service:latest
docker push vivek6899/simple-time-service:latest
```

## Run From Docker Hub (optional)

```bash
docker run -p 5000:5000 vivek6899/simple-time-service:latest
# docker run -p 80:5000 vivek6899/simple-time-service    if you want o run on http port 80

```

## Run as a Non-root User

The Dockerfile creates a non-root user `appuser` to run the application securely.


## Terraform 
we are creating ECS, SG and VPC in this script. 
a;so we are storing our statefile in bucket. As new update no need to use DynamoDB as S3 itself managed locking from terraofmr new version.