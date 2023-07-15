#!/bin/bash
  
echo -e "searching wp-includes\n\n"

grep -rnw "$1/wp-includes/" -e "$2"

echo -e "\n\nsearching plugins\n\n"

grep -rnw "$1/wp-content/plugins" -e "$2"

db_name=$(grep DB_NAME $1/wp-config.php | awk -F "'" '{print $4}')
db_user=$(grep DB_USER $1/wp-config.php | awk -F "'" '{print $4}')
db_pass=$(grep DB_PASSWORD $1/wp-config.php | awk -F "'" '{print $4}')
table_prefix=$(grep table_prefix $1/wp-config.php | awk -F "'" '{print $2}')

echo -e "\n\nsearching snipets\n\n"

echo "select id, name, description, code from ${table_prefix}snippets where code like \"%$2%\";" | mariadb --host="localhost" --user="$db_user" --database="$db_name" --password="$db_pass"
