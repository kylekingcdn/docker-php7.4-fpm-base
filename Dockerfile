FROM php:7.4-fpm

ARG APCU_VERSION=5.1.19

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure \
        zip && \
    docker-php-ext-install --jobs "$(nproc)" \
        bcmath \
        exif \
        gd \
        intl \
        mbstring \
        pcntl \
        pdo_mysql \
        zip && \
    pecl install \
        apcu-${APCU_VERSION} \
        redis && \
    pecl clear-cache && \
    docker-php-ext-enable \
        apcu \
        opcache \
        redis
