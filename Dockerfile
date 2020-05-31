# Dockerfile ubuntu example

# Create from dockerlemp
FROM robertoarcomano/dockerlemp

RUN rm -rf /var/www/html
COPY wordpress/ /var/www/html/

#COPY default /etc/nginx/sites-available/default

COPY wordpress.dump /tmp
RUN service mysql start && \
    grep DB_PASSWORD /var/www/html/wp-config.php |awk -F',' '{print $2}'|awk -F"'" '{print $2}' | xargs -I xxx echo "CREATE USER 'wordpress'@'localhost' identified by 'xxx'" | mysql && \
    echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost'; FLUSH PRIVILEGES;"|mysql && \
    mysqladmin create wordpress && mysql wordpress < /tmp/wordpress.dump
