# Base image
FROM debian:buster

# Install mariadb server and client
RUN apt update && apt install mariadb-server -y

# Copy custom configuration file
COPY ./tools/script.sh ./

# Set execute permissions for the script
RUN chmod +x /script.sh

# Expose the default mariadb port
EXPOSE 3306

# Run the destination script
# ENTRYPOINT ["./script.sh"]
CMD ["./script.sh"]
# Start mariadb daemon service
# CMD ["mysqld"]




# docker build -t my-mariadb-image .
# docker run -d -p 3306:3306 --name my-mariadb-container my-mariadb-image
# docker exec -it my-mariadb-container mysql -u abdo -p