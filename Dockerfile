# Use the Ubuntu base image
FROM ubuntu:latest

# Set non-interactive mode for package installations
ARG DEBIAN_FRONTEND=noninteractive

# Update the package lists, install NGINX, and add the PHP repository
RUN apt-get update && \
    apt-get install -y nginx software-properties-common && \
    add-apt-repository ppa:ondrej/php



RUN apt-get install -y curl
# Install PHP and its extensions
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

EXPOSE 80

COPY ./nginx/sites-available/default /etc/nginx/sites-available/default

# Copy your web content to the NGINX document root
COPY . /var/www/html

# Define a volume mapping between the "wodpress_volumn" and "/var/www/wp-content/uploads" directories.
VOLUME ["wodpress_volumn:/var/www/wp-content/uploads"]

# Start the PHP-FPM service for PHP version 8.1 and then launch the Nginx web server in daemon mode.
CMD service php8.1-fpm start && nginx -g 'daemon off;'