

## Dockerfile


## Use the Ubuntu base image
FROM ubuntu:latest

## Set non-interactive mode for package installations

ARG DEBIAN_FRONTEND=noninteractive

## Update the package lists, install NGINX, and add the PHP repository
RUN apt-get update && \
    apt-get install -y nginx software-properties-common && \
    add-apt-repository ppa:ondrej/php



RUN apt-get install -y curl
## Install PHP and its extensions
RUN apt-get update && \
    apt-get install -y \
    php8.1 \
    php8.1-fpm \
    php8.1-cli \
    php8.1-common \
    php8.1-mysql \
    php8.1-gd \
    php8.1-curl \
    php8.1-xml \
    php8.1-bcmath


## Expose port 80
EXPOSE 80


## Copy NGINX site configuration
COPY ./nginx/sites-available/default /etc/nginx/sites-available/default

## Copy your web content to the NGINX document root
COPY . /var/www/html

## Start PHP-FPM and NGINX

CMD service php8.1-fpm start && nginx -g 'daemon off;'


# Building the Docker Image

You can create the Docker image using the following command:

```bash
docker build -t wordpress_nginx:latest .
```


## If you want to build the Docker image without utilizing the cache, you can use the following command:
```bash
docker build -t wordpress_nginx:latest --no-cache .
```


## Run a Docker container with a specific name, detached mode, and port mapping
```bash
docker run --name some-nginx-01 -it -d -p 127.0.0.1:2124:80 wordpress_nginx:latest
```

# Push the Docker Image to Docker Hub

### Tag a Docker image with a new name and version
```bash
docker tag wordpress_nginx bamalik1996/wordpress_nginx:1.0
```

### Push a Docker image to a container registry
```bash
docker push bamalik1996/wordpress_nginx:1.0
```


CONTAINER ID  |    NAME        | CPU %   |  MEM USAGE / LIMIT   | MEM %  |  NET I/O    | BLOCK I/O  |  PIDS |
-------------   -------------    -------    -------------------   ------   -----------   ---------     -----
ff8b740a635c  | some-nginx-03  | 0.01%   |  21.1MiB / 7.682GiB  | 0.27%  |   806B / 0B |  0B / 0B   |  13   |


UID          |       PID         |        PPID       |         C          |         STIME        |       TTY        |         TIME           |     CMD                                      |
------------- ------------------- ------------------- -------------------- ---------------------- ------------------ ------------------------ ----------------------------------------------
www-data     |       2858        |        2857       |         0          |         19:38        |       ?          |         00:00:00       |     php-fpm: pool www                        |
www-data     |       2859        |        2857       |         0          |         19:38        |       ?          |         00:00:00       |     php-fpm: pool www                        |
root         |       2860        |        2827       |         0          |         19:38        |       ?          |         00:00:00       |     nginx: master process nginx -g daemon off|;
