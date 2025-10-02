.PHONY: help build deploy dev stop clean logs test health

help:
	@echo "Digital Agency Platform - Available Commands"
	@echo ""
	@echo "  make build      - Build frontend and backend"
	@echo "  make deploy     - Deploy using Docker Compose"
	@echo "  make dev        - Start development servers"
	@echo "  make stop       - Stop all Docker containers"
	@echo "  make clean      - Clean build artifacts and containers"
	@echo "  make logs       - View Docker logs"
	@echo "  make health     - Check application health"
	@echo "  make test       - Run tests (when available)"

build:
	@echo "Building frontend and backend..."
	@./build.sh

deploy:
	@echo "Deploying with Docker Compose..."
	@./deploy.sh

dev:
	@echo "Starting development servers..."
	@echo "Backend: http://localhost:8000"
	@echo "Frontend: http://localhost:3000"
	@make -j2 dev-backend dev-frontend

dev-backend:
	cd backend && uvicorn server:app --reload --host 0.0.0.0 --port 8000

dev-frontend:
	cd frontend && npm start

stop:
	@echo "Stopping Docker containers..."
	@docker compose down

clean: stop
	@echo "Cleaning build artifacts..."
	@rm -rf frontend/build frontend/node_modules
	@rm -rf backend/__pycache__ backend/venv
	@docker compose down -v
	@echo "Clean complete!"

logs:
	@docker compose logs -f

health:
	@echo "Checking backend health..."
	@curl -s http://localhost:8000/api/health | python3 -m json.tool || echo "Backend not responding"
	@echo ""
	@echo "Checking frontend..."
	@curl -s -o /dev/null -w "Frontend status: %{http_code}\n" http://localhost:3000

test:
	@echo "Running tests..."
	@cd backend && python -m py_compile server.py
	@cd frontend && npm run build
	@echo "Tests passed!"
