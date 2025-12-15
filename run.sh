#!/bin/bash

# Ensure script fails on error
set -e

echo "Starting environment..."
docker-compose up -d --build

echo "Waiting for services to be ready..."
sleep 10

echo "Seeding database..."
# Use the service name from docker-compose.yml instead of hoping the last container is the right one
docker-compose exec -T nodejs node seeds/seed.js

echo "Environment is up and seeded!"
