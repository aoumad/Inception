# Base image
FROM debian:bullseye

RUN apt update && apt install mariadb-server -y

COPY ./tools/script.sh ./

RUN chmod +x /script.sh

CMD ["./script.sh"]

# docker build -t my-mariadb-image .
# docker run -d -p 3306:3306 --name my-mariadb-container my-mariadb-image
# docker exec -it my-mariadb-container mysql -u abdo -p