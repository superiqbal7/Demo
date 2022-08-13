#!/bin/bash
#framework script
echo 'Docker laravel script running'

#framework script
echo 'configure permission'
cd /var/www/
chmod -R 755 html
chown -R www-data:www-data /var/www/html
chmod -R g+rw /var/www/html

#composer update
cd /var/www/html/
composer update

#framework script
echo 'Db migrate and seeding'
php artisan migrate
php artisan db:seed

#applicaiton script
php artisan cache:clear
php artisan view:clear
php artisan route:clear
php artisan clear-compiled
php artisan config:cache

echo 'Happy devopsing'

