# Deployment Guide

This guide provides instructions for building and deploying the Digital Agency application.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Local Development](#local-development)
- [Building the Application](#building-the-application)
- [Docker Deployment](#docker-deployment)
- [Manual Deployment](#manual-deployment)
- [CI/CD Pipeline](#cicd-pipeline)
- [Environment Variables](#environment-variables)
- [Troubleshooting](#troubleshooting)

## Prerequisites

### Required Software

- **Node.js** 20.x or higher
- **npm** 10.x or higher
- **Python** 3.12 or higher
- **pip** 24.x or higher
- **MongoDB** 7.0 or higher (for production)
- **Docker** and **Docker Compose** (optional, for containerized deployment)

### Installation

**Node.js and npm:**
```bash
# Download from https://nodejs.org/
# Or using nvm:
nvm install 20
nvm use 20
```

**Python:**
```bash
# Download from https://www.python.org/
# Or using system package manager:
sudo apt install python3.12 python3-pip  # Ubuntu/Debian
brew install python@3.12                  # macOS
```

**Docker:**
```bash
# Follow instructions at https://docs.docker.com/get-docker/
```

## Local Development

### Backend Development

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Create a virtual environment (recommended):
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Set up environment variables:
   ```bash
   # Create or edit .env file
   echo "MONGO_URL=mongodb://localhost:27017/digital_agency" > .env
   ```

5. Run the backend server:
   ```bash
   uvicorn server:app --reload --host 0.0.0.0 --port 8000
   ```

6. Access the API:
   - API: http://localhost:8000
   - API Documentation: http://localhost:8000/docs
   - Alternative Docs: http://localhost:8000/redoc

### Frontend Development

1. Navigate to the frontend directory:
   ```bash
   cd frontend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Set up environment variables:
   ```bash
   # Create or edit .env file
   echo "REACT_APP_BACKEND_URL=http://localhost:8000" > .env
   ```

4. Run the development server:
   ```bash
   npm start
   ```

5. Access the application:
   - Frontend: http://localhost:3000

## Building the Application

### Using Build Script

The easiest way to build both backend and frontend:

```bash
./build.sh
```

This script will:
1. Install backend dependencies
2. Install frontend dependencies
3. Build the frontend for production

### Manual Build

**Backend:**
```bash
cd backend
pip install -r requirements.txt
```

**Frontend:**
```bash
cd frontend
npm install
npm run build
```

The frontend build output will be in `frontend/build/` directory.

## Docker Deployment

### Quick Start with Docker Compose

1. Ensure Docker and Docker Compose are installed
2. Run the deployment script:
   ```bash
   ./deploy.sh
   ```

This will:
- Build Docker images for backend and frontend
- Start MongoDB, backend, and frontend containers
- Set up networking between containers

### Manual Docker Deployment

**Build images:**
```bash
docker-compose build
```

**Start services:**
```bash
docker-compose up -d
```

**View logs:**
```bash
docker-compose logs -f
```

**Stop services:**
```bash
docker-compose down
```

**Stop and remove volumes:**
```bash
docker-compose down -v
```

### Access the Application

After deployment:
- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:8000
- **API Docs:** http://localhost:8000/docs

### Docker Image Management

**View running containers:**
```bash
docker-compose ps
```

**Rebuild specific service:**
```bash
docker-compose build backend
docker-compose up -d backend
```

**View container logs:**
```bash
docker-compose logs backend
docker-compose logs frontend
docker-compose logs mongodb
```

## Manual Deployment

### Production Backend Deployment

1. Set up a Python environment:
   ```bash
   python -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

2. Configure environment variables:
   ```bash
   export MONGO_URL="mongodb://your-mongo-host:27017/digital_agency"
   ```

3. Run with production server:
   ```bash
   uvicorn server:app --host 0.0.0.0 --port 8000 --workers 4
   ```

### Production Frontend Deployment

1. Build the frontend:
   ```bash
   cd frontend
   npm install
   npm run build
   ```

2. Serve with a static file server:
   
   **Using serve:**
   ```bash
   npm install -g serve
   serve -s build -l 3000
   ```
   
   **Using nginx:**
   - Copy `build/` contents to nginx root (e.g., `/var/www/html`)
   - Use the provided `nginx.conf` as configuration
   - Restart nginx

### Database Setup

1. Install MongoDB:
   ```bash
   # Ubuntu/Debian
   sudo apt install mongodb
   
   # macOS
   brew install mongodb-community
   ```

2. Start MongoDB:
   ```bash
   # Ubuntu/Debian
   sudo systemctl start mongodb
   
   # macOS
   brew services start mongodb-community
   ```

3. Create database (automatically created on first run)

## CI/CD Pipeline

The project includes a GitHub Actions workflow (`.github/workflows/ci-cd.yml`) that:

1. **On every push/PR:**
   - Tests backend (Python syntax check)
   - Tests frontend (npm build)
   
2. **On main branch push:**
   - Builds Docker images
   - Caches layers for faster builds

### Setting Up CI/CD

1. Push code to GitHub
2. Workflow runs automatically
3. Check Actions tab for build status

### Extending CI/CD

To add deployment to cloud platforms:

**Example for AWS ECR:**
```yaml
- name: Configure AWS credentials
  uses: aws-actions/configure-aws-credentials@v4
  with:
    aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
    aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    aws-region: us-east-1

- name: Login to Amazon ECR
  uses: aws-actions/amazon-ecr-login@v2

- name: Push to ECR
  run: |
    docker tag digital-agency-backend:latest $ECR_REGISTRY/backend:latest
    docker push $ECR_REGISTRY/backend:latest
```

## Environment Variables

### Backend (.env)

```bash
MONGO_URL=mongodb://localhost:27017/digital_agency
```

### Frontend (.env)

```bash
REACT_APP_BACKEND_URL=http://localhost:8000
```

### Production Considerations

- Use secure MongoDB connection strings (with authentication)
- Enable HTTPS for production
- Set appropriate CORS origins in backend
- Use environment-specific URLs

## Troubleshooting

### Frontend Build Issues

**Tailwind CSS errors:**
- Ensure `tailwindcss` version is `^3.4.18` in `package.json`
- Run `npm install` to update dependencies

**Build fails:**
```bash
cd frontend
rm -rf node_modules package-lock.json
npm install
npm run build
```

### Backend Issues

**MongoDB connection error:**
- Verify MongoDB is running: `systemctl status mongodb` or `brew services list`
- Check connection string in `.env`
- Ensure MongoDB port (27017) is accessible

**Module import errors:**
```bash
cd backend
pip install --upgrade -r requirements.txt
```

### Docker Issues

**Port already in use:**
```bash
# Find process using port
lsof -i :8000  # or :3000, :27017
# Kill process or change port in docker-compose.yml
```

**Permission denied:**
```bash
sudo usermod -aG docker $USER
# Logout and login again
```

**Build cache issues:**
```bash
docker-compose build --no-cache
```

### General Issues

**Check service status:**
```bash
# Docker deployment
docker-compose ps
docker-compose logs

# Manual deployment
ps aux | grep uvicorn
ps aux | grep nginx
```

**Network connectivity:**
```bash
# Test backend
curl http://localhost:8000/health

# Test frontend
curl http://localhost:3000
```

## Performance Optimization

### Frontend

- Enable Nginx compression (already configured in `nginx.conf`)
- Use CDN for static assets
- Enable browser caching

### Backend

- Use multiple workers: `uvicorn server:app --workers 4`
- Enable MongoDB indexes
- Implement caching with Redis

### Database

- Create indexes for frequently queried fields
- Use connection pooling
- Regular backups

## Security Best Practices

1. **Never commit sensitive data:**
   - Use `.env` files (already in `.gitignore`)
   - Use secrets management in production

2. **API Security:**
   - Implement rate limiting
   - Add authentication/authorization
   - Use HTTPS in production

3. **Database Security:**
   - Enable MongoDB authentication
   - Use encrypted connections
   - Regular security updates

## Support

For issues or questions:
1. Check this documentation
2. Review logs: `docker-compose logs` or application logs
3. Open an issue on GitHub

## Additional Resources

- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [React Documentation](https://react.dev/)
- [Docker Documentation](https://docs.docker.com/)
- [MongoDB Documentation](https://docs.mongodb.com/)
- [Nginx Documentation](https://nginx.org/en/docs/)
