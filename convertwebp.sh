#!/usr/bin/env bash
  
root_dir="/var/www/wordpress/"

IMAGE_FILES=$(grep -E '\.(jpg|jpeg|png)\s' /var/log/nginx/access.log | awk '{print $7}' | sort | uniq)

for image in $IMAGE_FILES; do
        if [ -f "${root_dir}$image" ]; then
                if [ ! -f "${root_dir}dist/webp$image.webp" ]; then
                        echo "converting $image"
                        mkdir -p ${root_dir}dist/webp$image
                        rm -rf ${root_dir}dist/webp$image
                        cwebp -q 80 ${root_dir}$image -o ${root_dir}dist/webp$image.webp
                fi
        fi
done
