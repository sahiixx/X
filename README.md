# Digital Agency Platform

A modern digital agency platform with FastAPI backend and React frontend, featuring portfolio management, service listings, and more.

## Features

- **Backend**: FastAPI-based REST API with MongoDB integration
- **Frontend**: React application with Tailwind CSS styling
- **Documentation**: Mintlify-powered documentation
- **Containerization**: Docker and Docker Compose support
- **CI/CD**: GitHub Actions workflow for automated testing and deployment

## Quick Start

### Using Docker (Recommended)

```bash
# Option 1: Using deploy script
./deploy.sh

# Option 2: Using Makefile
make deploy
```

This will start all services (MongoDB, Backend, Frontend) using Docker Compose.

### Using Makefile Commands

```bash
make help       # Show all available commands
make build      # Build the application
make deploy     # Deploy with Docker
make dev        # Start development servers
make stop       # Stop all containers
make logs       # View logs
make health     # Check health status
```

### Manual Setup

See [DEPLOYMENT.md](./DEPLOYMENT.md) for detailed instructions on:
- Local development setup
- Building the application
- Manual deployment
- Environment configuration
- Troubleshooting

## Project Structure

```
.
├── backend/          # FastAPI backend application
├── frontend/         # React frontend application
├── docs/            # Documentation (Mintlify)
├── .github/         # GitHub Actions workflows
├── docker-compose.yml
├── build.sh         # Build script
├── deploy.sh        # Deployment script
└── DEPLOYMENT.md    # Detailed deployment guide
```

## Documentation

Install the [Mintlify CLI](https://www.npmjs.com/package/mint) to preview your documentation changes locally. To install, use the following command:

```
npm i -g mint
```

Run the following command at the root of your documentation, where your `docs.json` is located:

```
mint dev
```

View your local preview at `http://localhost:3000`.

## Development

Install the [Mintlify CLI](https://www.npmjs.com/package/mint) to preview your documentation changes locally. To install, use the following command:

```
npm i -g mint
```

Run the following command at the root of your documentation, where your `docs.json` is located:

```
mint dev
```

View your local preview at `http://localhost:3000`.

## Access Points

After deployment:
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8000
- **API Documentation**: http://localhost:8000/docs

## Development

- **Frontend**: `cd frontend && npm start`
- **Backend**: `cd backend && uvicorn server:app --reload`

## Publishing Documentation Changes

Install our GitHub app from your [dashboard](https://dashboard.mintlify.com/settings/organization/github-app) to propagate changes from your repo to your deployment. Changes are deployed to production automatically after pushing to the default branch.

## CI/CD Pipeline

The project includes automated CI/CD using GitHub Actions:
- Runs tests on every push and pull request
- Builds Docker images on main branch
- See `.github/workflows/ci-cd.yml` for details

## Need Help?

### Deployment Issues
See [DEPLOYMENT.md](./DEPLOYMENT.md) for comprehensive troubleshooting

### Documentation Issues
- If your dev environment isn't running: Run `mint update` to ensure you have the most recent version of the CLI.
- If a page loads as a 404: Make sure you are running in a folder with a valid `docs.json`.

### Resources
- [Deployment Guide](./DEPLOYMENT.md)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [React Documentation](https://react.dev/)
- [Mintlify Documentation](https://mintlify.com/docs)
