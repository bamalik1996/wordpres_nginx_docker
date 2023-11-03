

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

# Use Different Docker Container Commands

### List running Docker containers

```bash
docker ps
```

CONTAINER ID | IMAGE |  COMMAND | CREATED | STATUS | PORTS | NAMES |
-----------   ------   -------    ------    ------   -----   -----
32ed12171f92 | b6a588413b51  | "/bin/sh -c 'service…" |  2 days ago  | Up About an hour  | 127.0.0.1:2124->80/tcp  | some-nginx-03 |

### Stop running Docker containers

```bash
docker stop CONTAINER ID
```
```bash
docker stop 32ed12171f92 
```

### Remove stop Docker containers

```bash
docker rm CONTAINER ID
```
```bash
docker rm 32ed12171f92 
```

### Inspect Docker containers

```bash
docker inspect CONTAINER ID
```
```bash
docker inspect 32ed12171f92 
```
```json
[
    {
        "Id": "ff8b740a635c3fbc2b4d31a83388f7c46ae6b40c0604a53ff1f98c914d219501",
        "Created": "2023-11-02T06:28:22.638830408Z",
        "Path": "/bin/sh",
        "Args": [
            "-c",
            "service php8.1-fpm start \u0026\u0026 nginx -g 'daemon off;'"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 13503,
            "ExitCode": 0
        }.....
```

### 


### Inspect Docker containers

```bash
docker exec -it [Container ID or Container Name] command 
```

```bash
docker exec -it some-nginx-03 tail -f /var/log/nginx/access.log 
```

### Create a new image from a Docker Container

```bash
docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
```

```bash
docker commit  some-nginx-03 wordpress_nginx:v1 
```
#### Response

```bash
sha256:3ffd87c8a0482b5665115803e3979030911af711ce121ad5d12e5c7835b93654
```

### Command to copy files/folders between the container and the host

```bash
docker cp [OPTIONS] CONTAINER:SRC_PATH DEST_PATH|-
``` 
```bash
docker cp [OPTIONS] SRC_PATH|- CONTAINER:DEST_PATH
``` 

```bash
docker cp some-nginx-02:/etc/nginx/sites-available/default ./nginx/sites-available/default
``` 

```bash
docker cp ./nginx/sites-available/default some-nginx-02:/etc/nginx/sites-available/default
``` 

## Command to view the resource usage of containers
```bash
docker stats [Container ID]
``` 

```bash
docker stats ff8b740a635c3fbc2b4d31a83388f7c46ae6b40c0604a53ff1f98c914d219501
```


<table><thead><tr><th>CONTAINER ID</th><th>NAME</th><th>CPU %</th><th>MEM USAGE / LIMIT</th><th>MEM %</th><th>NET I/O</th><th>BLOCK I/O</th><th>PIDS</th></tr></thead><tbody><tr><td>ff8b740a635c</td><td>some-nginx-03</td><td>0.01%</td><td>21.1MiB / 7.682GiB</td><td>0.27%</td><td>806B / 0B</td><td>0B / 0B</td><td>13</td></tr></tbody></table>



## Command to view the running processes inside a container
```bash
docker top [Container ID]
``` 

```bash
docker top ff8b740a635c3fbc2b4d31a83388f7c46ae6b40c0604a53ff1f98c914d219501
```

<table><thead><tr><th>UID</th><th>PID</th><th>PPID</th><th>C</th><th>STIME</th><th>TTY</th><th>TIME</th><th>CMD</th></tr></thead><tbody><tr><td>www-data</td><td>2858</td><td>2857</td><td>0</td><td>19:38</td><td>?</td><td>00:00:00</td><td>php-fpm: pool www</td></tr><tr><td>www-data</td><td>2859</td><td>2857</td><td>0</td><td>19:38</td><td>?</td><td>00:00:00</td><td>php-fpm: pool www</td></tr><tr><td>root</td><td>2860</td><td>2827</td><td>0</td><td>19:38</td><td>?</td><td>00:00:00</td><td>nginx: master process nginx -g daemon off</td></tr></tbody></table>

## Command to start a stopped container
```bash
docker start [Container ID]
``` 

```bash
docker start ff8b740a635c3fbc2b4d31a83388f7c46ae6b40c0604a53ff1f98c914d219501
```

## Command to pause a running container
```bash
docker stop [Container ID]
``` 

```bash
docker stop ff8b740a635c3fbc2b4d31a83388f7c46ae6b40c0604a53ff1f98c914d219501
```

## Command to unpause a paused container
```bash
docker stop [Container ID]
``` 

```bash
docker stop ff8b740a635c3fbc2b4d31a83388f7c46ae6b40c0604a53ff1f98c914d219501
```

## Command to unpause a paused container
```bash
docker rename CONTAINER NEW_NAME
``` 

```bash
docker rename ff8b740a635c3fbc2b4d31a83388f7c46ae6b40c0604a53ff1f98c914d219501 some-nginx-rename
```


##  Command to wait for a container to exit and then display its exit code
```bash
docker wait CONTAINER ID
``` 

```bash
docker wait ff8b740a635c3fbc2b4d31a83388f7c46ae6b40c0604a53ff1f98c914d219501
```

##  Command to display the public-facing port that a container is listening on
```bash
docker port CONTAINER ID
``` 

```bash
docker port ff8b740a635c3fbc2b4d31a83388f7c46ae6b40c0604a53ff1f98c914d219501
```
####  Response

```bash
80/tcp -> 127.0.0.1:2124
```

##  Command to update a container's resource limits
```bash
docker update [OPTIONS] CONTAINER [CONTAINER...]
``` 

```bash
docker update --cpu-shares 512 ff8b740a635c3fbc2b4d31a83388f7c46ae6b40c0604a53ff1f98c914d219501
```


## Command to restart a running container
```bash
docker restart [CONTAINER ID]
``` 

```bash
docker restart ff8b740a635c3fbc2b4d31a83388f7c46ae6b40c0604a53ff1f98c914d219501
```