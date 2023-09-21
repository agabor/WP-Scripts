#!/usr/bin/env bash

wp_path='/var/www/wordpress'

config_path="$wp_path/wp-config.php"
db_name=$(grep DB_NAME $config_path | awk -F "'" '{print $4}')
db_user=$(grep DB_USER $config_path | awk -F "'" '{print $4}')
db_pass=$(grep DB_PASSWORD $config_path | awk -F "'" '{print $4}')

sudo mariadb -e "DROP USER IF EXISTS '$db_user'@'localhost';"
sudo mariadb -e "DROP DATABASE IF EXISTS $db_name;"
sudo mariadb -e "CREATE DATABASE $db_name;"
sudo mariadb -e "CREATE USER '$db_user'@'localhost' IDENTIFIED BY '$db_pass';"
sudo mariadb -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'localhost';"
