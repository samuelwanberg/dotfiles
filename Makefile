# Variables
IMAGE_NAME := dotfiles
DOCKERFILE := Dockerfile
COMPOSE_FILE := docker-compose.yml
SERVICE := dotfiles
TAG := latest

# Docker build
.PHONY: build
build:
	@echo "Starting docker image..."
	docker build -t $(IMAGE_NAME):$(TAG) -f $(DOCKERFILE) .

# Docker compose up
.PHONY: up
up:
	@echo "Starting services with docker compose..."
	docker compose -f $(COMPOSE_FILE) up -d

# Docker compose down
.PHONY: down
down:
	@echo "Stopping services with docker compose..."
	docker compose -f $(COMPOSE_FILE) down

# Docker compose logs
.PHONY: logs
logs:
	@echo "Showing logs..."
	docker compose -f $(COMPOSE_FILE) logs -f

# Clean Docker images and containers
.PHONY: clean
clean:
	@echo "Cleaning up Docker images and containers..."
	docker compose -f $(COMPOSE_FILE) down --rmi all --volumes --remove-orphans

# Clean Docker images and containers
.PHONY: exec
exec:
	@echo "Exec bash container access..."
	docker compose -f $(COMPOSE_FILE) exec $(SERVICE) zsh

# Help menu
.PHONY: help
help:
	@echo "Makefile commands:"
	@echo " make build - Build Docker image"
	@echo " make up - Start services using Docker compose"
	@echo " make down - Stop services"
	@echo " make logs - View container logs"
	@echo " make exec - Access shell container"
	@echo " make clean - Clean up Docker images and containers"

