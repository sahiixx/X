# Contributing Guide

Thank you for considering contributing to the Digital Agency Platform!

## Development Setup

### Prerequisites

- Node.js 20.x or higher
- Python 3.12 or higher
- MongoDB 7.0 or higher
- Docker (optional, for containerized development)

### Getting Started

1. **Fork and clone the repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/X.git
   cd X
   ```

2. **Set up the backend:**
   ```bash
   cd backend
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -r requirements.txt
   cp .env.example .env
   # Edit .env with your MongoDB connection string
   ```

3. **Set up the frontend:**
   ```bash
   cd frontend
   npm install
   cp .env.example .env
   # Edit .env with your backend URL
   ```

4. **Start development servers:**
   ```bash
   # Option 1: Use Makefile
   make dev

   # Option 2: Manual
   # Terminal 1 - Backend
   cd backend && uvicorn server:app --reload

   # Terminal 2 - Frontend
   cd frontend && npm start
   ```

## Development Workflow

### Making Changes

1. **Create a new branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes:**
   - Write clean, readable code
   - Follow existing code style
   - Add comments for complex logic
   - Update documentation if needed

3. **Test your changes:**
   ```bash
   # Test backend
   cd backend
   python -m py_compile server.py

   # Test frontend build
   cd frontend
   npm run build
   ```

4. **Commit your changes:**
   ```bash
   git add .
   git commit -m "feat: add new feature"
   ```

### Commit Message Convention

Follow conventional commits format:

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

Examples:
```
feat: add user authentication
fix: resolve MongoDB connection issue
docs: update deployment guide
```

### Pull Request Process

1. **Push your branch:**
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create a Pull Request:**
   - Go to the repository on GitHub
   - Click "New Pull Request"
   - Select your branch
   - Fill in the PR template

3. **PR Requirements:**
   - Clear description of changes
   - Reference any related issues
   - Ensure CI checks pass
   - Update documentation if needed

## Code Style Guidelines

### Backend (Python)

- Follow PEP 8 style guide
- Use type hints where appropriate
- Add docstrings for functions and classes
- Keep functions small and focused

Example:
```python
async def get_service(service_id: str) -> dict:
    """
    Retrieve a service by ID.
    
    Args:
        service_id: The unique identifier of the service
        
    Returns:
        Service data as a dictionary
    """
    service = await db.services.find_one({"id": service_id})
    return service
```

### Frontend (React/JavaScript)

- Use functional components with hooks
- Follow existing naming conventions
- Use meaningful variable names
- Add comments for complex logic
- Use Tailwind CSS for styling

Example:
```javascript
const ServiceCard = ({ service }) => {
  const [isLoading, setIsLoading] = useState(false);
  
  const handleClick = async () => {
    setIsLoading(true);
    // Handle service selection
    setIsLoading(false);
  };
  
  return (
    <div className="service-card">
      {/* Card content */}
    </div>
  );
};
```

## Project Structure

```
.
├── backend/
│   ├── server.py           # FastAPI application
│   ├── requirements.txt    # Python dependencies
│   ├── .env               # Environment variables (not committed)
│   └── Dockerfile         # Backend container config
├── frontend/
│   ├── src/
│   │   ├── components/    # React components
│   │   ├── App.js        # Main application
│   │   └── index.js      # Entry point
│   ├── public/           # Static assets
│   ├── package.json      # Node dependencies
│   └── Dockerfile        # Frontend container config
├── .github/
│   └── workflows/
│       └── ci-cd.yml     # CI/CD pipeline
├── docker-compose.yml    # Development containers
├── docker-compose.prod.yml  # Production containers
├── DEPLOYMENT.md         # Deployment guide
└── README.md            # Project overview
```

## Testing

Currently, the project uses basic validation:

**Backend:**
```bash
cd backend
python -m py_compile server.py
```

**Frontend:**
```bash
cd frontend
npm run build
```

We welcome contributions to add comprehensive testing!

## Documentation

When adding new features:

1. **Update relevant documentation:**
   - README.md - for user-facing features
   - DEPLOYMENT.md - for deployment-related changes
   - Code comments - for complex logic

2. **API Documentation:**
   - FastAPI automatically generates docs at `/docs`
   - Add clear docstrings to endpoints

3. **Component Documentation:**
   - Add prop types and comments to React components

## Docker Development

### Building Images

```bash
# Build all services
docker compose build

# Build specific service
docker compose build backend
docker compose build frontend
```

### Running Containers

```bash
# Start all services
docker compose up -d

# View logs
docker compose logs -f

# Stop services
docker compose down
```

## Troubleshooting Development Issues

### Backend Issues

**Import errors:**
```bash
cd backend
pip install -r requirements.txt --upgrade
```

**Database connection:**
- Ensure MongoDB is running
- Check MONGO_URL in .env
- Verify port 27017 is accessible

### Frontend Issues

**Build errors:**
```bash
cd frontend
rm -rf node_modules package-lock.json
npm install
npm run build
```

**Dependency conflicts:**
- Check package.json versions
- Ensure Node.js version is 20+

### Docker Issues

**Container won't start:**
```bash
docker compose down -v
docker compose build --no-cache
docker compose up -d
```

**Port conflicts:**
```bash
# Find process using port
lsof -i :8000
# Kill process or change port in docker-compose.yml
```

## Getting Help

- Check existing documentation
- Search existing issues
- Ask in discussions
- Create a new issue with details:
  - What you're trying to do
  - What happened
  - Error messages
  - Your environment (OS, versions, etc.)

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Focus on constructive feedback
- Help others learn

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

## Questions?

Feel free to open an issue for any questions about contributing!
