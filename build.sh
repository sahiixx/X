#!/bin/bash

# Build script for the Digital Agency application
set -e

echo "🚀 Starting build process..."

# Build backend
echo "📦 Building backend..."
cd backend
pip install -r requirements.txt
cd ..

# Build frontend
echo "📦 Building frontend..."
cd frontend
npm install
npm run build
cd ..

echo "✅ Build completed successfully!"
