.PHONY: help build up down logs shell test lint format clean dev prod

help:	## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Development commands
dev:	## Start development environment
	cp .env.dev .env
	docker-compose -f docker-compose.dev.yml up --build

dev-down:	## Stop development environment
	docker-compose -f docker-compose.dev.yml down

# Production commands
prod:	## Start production environment
	cp .env.prod .env
	docker-compose up --build -d

prod-down:	## Stop production environment
	docker-compose down

# Docker commands
build:	## Build Docker images
	docker-compose build

up:	## Start containers
	docker-compose up -d

down:	## Stop containers
	docker-compose down

logs:	## Show container logs
	docker-compose logs -f

shell:	## Open shell in web container
	docker-compose exec web bash

# Local development (without Docker)
install:	## Install development dependencies
	pip install -r requirements-dev.txt

runserver:	## Run Django development server
	python manage.py runserver

migrate:	## Run database migrations
	python manage.py migrate

makemigrations:	## Create database migrations
	python manage.py makemigrations

collectstatic:	## Collect static files
	python manage.py collectstatic --noinput

# Testing and code quality
test:	## Run tests
	python -m pytest

test-coverage:	## Run tests with coverage
	python -m coverage run -m pytest
	python -m coverage report
	python -m coverage html

lint:	## Run linting
	flake8 .
	black --check .

format:	## Format code
	black .
	isort .

# Cleanup
clean:	## Clean up Docker resources
	docker system prune -f
	docker volume prune -f

clean-all:	## Clean up all Docker resources (including images)
	docker system prune -af
	docker volume prune -f