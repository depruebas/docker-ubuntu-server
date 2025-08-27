#!/bin/bash

U_ID = $(shell id -u)

.PHONY: all create_network ubuntuserver

# Define la ruta base del directorio actual
BASE_DIR := $(CURDIR)
NETWORK_NAME := mysql-network
SUBNET := 172.23.0.0/24

all: create_network ubuntuserver

create_network:
	@if ! docker network inspect $(NETWORK_NAME) >/dev/null 2>&1; then \
		echo "Creating network $(NETWORK_NAME) with subnet $(SUBNET)..."; \
		docker network create --subnet=$(SUBNET) $(NETWORK_NAME); \
	else \
		echo "Network $(NETWORK_NAME) already exists."; \
	fi

ubuntuserver:
	@echo "Starting MySql replica 1 container..."
	cd $(BASE_DIR)/ubuntu-server && UserUID=${U_ID} docker-compose up -d

down:
	@echo "Destruyendo containers ..."
	cd $(BASE_DIR)/ubuntu-server && UserUID=${U_ID} docker-compose down

build:
	@echo 'Reiniciando containers ...'
	cd $(BASE_DIR)/ubuntu-server && UserUID=${U_ID} docker-compose build

stop:
	@echo "Parando containers ..."
	cd $(BASE_DIR)/ubuntu-server && UserUID=${U_ID} docker-compose stop

shell1:
	@echo "Enter into MySql Rep1 container..."
	UserUID=${U_ID} docker exec -it --user ${U_ID} ubuntu_24_server bash
