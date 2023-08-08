build:
	mkdir -p ./wordpress
	mkdir -p ./mariadb
	docker compose -f ./srcs/docker-compose.yml up --build

dcache:
	docker system prune -a

down:
	docker compose -f ./srcs/docker-compose.yml down

down_all:
	docker compose -f ./srcs/docker-compose.yml down -v

dvolume:
	rm -r ./mariadb
	rm -r ./wordpress