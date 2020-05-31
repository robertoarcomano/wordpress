# Dockerfile ubuntu example

# 1. Create from dockerlemp
FROM robertoarcomano/dockerlemp

# 2. Replace main web directory with wordpress one
RUN rm -rf /var/www/html

COPY wordpress /var/www/html

# 4. Set domain name on nginx site file
RUN sed -ri "s/server_name .*/server_name robertoarcomano.it;/g" /etc/nginx/sites-available/default

# 4. DB Configuration, retrieve password from wordpress and put it into the DB and extract wordpress DB
COPY wordpress.dump /tmp
RUN service mysql start && \
    grep DB_PASSWORD /var/www/html/wp-config.php |awk -F',' '{print $2}'|awk -F"'" '{print $2}' | xargs -I xxx echo "CREATE USER 'wordpress'@'localhost' identified by 'xxx'" | mysql && \
    echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost'; FLUSH PRIVILEGES;"|mysql && \
    mysqladmin create wordpress && mysql wordpress < /tmp/wordpress.dump

