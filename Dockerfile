# Dockerfile ubuntu example

# Create from ubuntu
FROM ubuntu:20.04

RUN env TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y openssh-server mysql-server nginx php php-mysql vim supervisor php7.4-fpm wordpress
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY default /etc/nginx/sites-available/default
RUN rm -rf /var/www/html && ln -s /usr/share/wordpress /var/www/html

COPY db.sql /tmp/db.sql
RUN service mysql start && mysql < /tmp/db.sql

CMD ["/usr/bin/supervisord"]
