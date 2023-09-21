FROM php:7.1-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid

# Install system dependencies
#RUN apt-get update && apt-get install -y \
#    git \
#    curl \
#    libpng-dev \
#    libonig-dev \
#    libxml2-dev \
#    libpq-dev \
#    zip \
#    unzip

RUN apt-get update && \
    apt-get install -y --no-install-recommends  libssl-dev zlib1g-dev curl git unzip libxml2-dev libpq-dev libzip-dev
#
#
#
#
#

## Clear cache
#RUN apt-get clean && rm -rf /var/lib/apt/lists/*
#
## Install PHP extensions
#RUN docker-php-ext-install pdo pdo_pgsql nodejs npm mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user


# Set working directory
WORKDIR /var/www

USER $user

EXPOSE 6001
