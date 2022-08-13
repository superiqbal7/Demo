#!/bin/bash
#framework script
echo 'laravel script running'
cd /var/www/devopsmakeeasy.com/
pwd

#composer update
php artisan cache:clear
php artisan view:clear
php artisan route:clear
php artisan clear-compiled
php artisan config:cache

#framework script
echo 'Db migrate and seeding'
php artisan migrate
php artisan db:seed

#framework script
echo 'configure permission'
cd /var/www/
chmod -R 755 devopsmakeeasy.com
sudo chown -R www-data:www-data /var/www/devopsmakeeasy.com
sudo chmod -R g+rw /var/www/devopsmakeeasy.com
echo 'Happy devopsing'

