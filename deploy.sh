#!/bin/bash

# Deployment script using Docker Compose
set -e

echo "🚀 Starting deployment..."

# Check if Docker and Docker Compose are installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Determine which compose command to use
if command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
else
    COMPOSE_CMD="docker compose"
fi

# Build and start services
echo "🔨 Building Docker images..."
$COMPOSE_CMD build

echo "🚀 Starting services..."
$COMPOSE_CMD up -d

echo "✅ Deployment completed successfully!"
echo ""
echo "📊 Services status:"
$COMPOSE_CMD ps

echo ""
echo "🌐 Access the application:"
echo "   Frontend: http://localhost:3000"
echo "   Backend API: http://localhost:8000"
echo "   Backend Docs: http://localhost:8000/docs"
