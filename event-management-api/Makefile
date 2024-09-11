# Makefile

# Variables
DOCKER_COMPOSE = docker-compose
DOCKER_COMPOSE_FILE = docker-compose.yml
DOCKER_COMPOSE_DIR = .

# Commands
.PHONY: deploy down remove clean

# Deploy the application
deploy:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up --build -d

# Stop and remove containers
down:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down

# Remove all containers, networks, and volumes (use with caution)
remove:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down --volumes --remove-orphans

# Clean up dangling images and unused volumes
clean:
	docker system prune -f
	docker volume prune -f
