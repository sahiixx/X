# Quick Start Guide

Get the Digital Agency platform up and running in minutes.

## Prerequisites

Ensure you have installed:
- Docker and Docker Compose
- OR Node.js 20+ and Python 3.12+ for manual setup

## Option 1: Docker (Recommended)

The fastest way to get started:

```bash
# Clone the repository
git clone https://github.com/sahiixx/X.git
cd X

# Deploy with one command
./deploy.sh
```

This will:
- ✅ Start MongoDB database
- ✅ Build and start the backend API
- ✅ Build and start the frontend

**Access the application:**
- Frontend: http://localhost:3000
- Backend API: http://localhost:8000
- API Docs: http://localhost:8000/docs

**Stop the application:**
```bash
docker compose down
```

## Option 2: Manual Setup

### Backend

```bash
cd backend
pip install -r requirements.txt
uvicorn server:app --reload
```

### Frontend

```bash
cd frontend
npm install
npm start
```

### MongoDB

Make sure MongoDB is running on `localhost:27017` or update the `MONGO_URL` in `backend/.env`.

## Troubleshooting

**Port already in use:**
```bash
# Find and kill process using port 3000, 8000, or 27017
lsof -i :3000
kill -9 <PID>
```

**Docker build issues:**
```bash
docker compose down -v
docker compose build --no-cache
docker compose up -d
```

**Frontend build errors:**
```bash
cd frontend
rm -rf node_modules package-lock.json
npm install
npm run build
```

## Next Steps

- 📖 Read [DEPLOYMENT.md](./DEPLOYMENT.md) for detailed deployment options
- 🔧 Configure environment variables in `.env` files
- 🚀 Deploy to production (see deployment guide)

## Getting Help

- Check [DEPLOYMENT.md](./DEPLOYMENT.md) for comprehensive documentation
- Review logs: `docker compose logs -f`
- Open an issue on GitHub
