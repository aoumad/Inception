DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

build:
	mkdir -p wordpress
	mkdir -p mariadb
	docker compose -f $(DOCKER_COMPOSE_FILE) up --build

dcache:
	docker system prune -a

down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down

down_all:
	docker compose -f $(DOCKER_COMPOSE_FILE) down -v

dvolume:
	rm -r mariadb
	rm -r wordpress
	docker volume rm -f srcs_wp_volume srcs_db_volume

clear: down_all dcache dvolume