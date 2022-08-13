FROM php:8.0-fpm

# Copy composer.lock and composer.json into the working directory
COPY composer.lock composer.json /var/www/html/



#secret data


# Set working directory
WORKDIR /var/www/html/

# Install dependencies for the operating system software
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    nano \
    libzip-dev \
    unzip \
    git \
    libonig-dev \
    curl \
    openssl


# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions for php
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-install ctype
RUN docker-php-ext-install tokenizer
RUN docker-php-ext-install pdo
RUN docker-php-ext-install mysqli
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd

# gmp php ext install
RUN apt-get update && apt-get install -y gnupg gnupg2 gnupg1 \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010 AA8E81B4331F7F50 9D6D8F6BC857C906 \
    && apt-get install -y libgmp-dev --fix-missing \
    && docker-php-ext-install gmp


# imagick php ext install
RUN apt-get update; \
    # Imagick extension
    apt-get install -y libmagickwand-dev; \
    pecl install imagick; \
    docker-php-ext-enable imagick; \
    # Success
    true



# Install composer (php package manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy existing application directory contents to the working directory
COPY . /var/www/html


# Assign permissions of the working directory to the www-data user
RUN chown -R www-data:www-data \
        /var/www/html/storage \
        /var/www/html/bootstrap/cache


#composer update
#RUN composer update
WORKDIR /var/www/html/
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer update

#platform task
RUN php artisan cache:clear
RUN php artisan view:clear
RUN php artisan route:clear
RUN php artisan clear-compiled
RUN php artisan config:cache

#framework script
#RUN php artisan migrate
#RUN php artisan db:seed

# Expose port 9000 and start php-fpm server (for FastCGI Process Manager)
EXPOSE 9000
CMD ["php-fpm"]
