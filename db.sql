UPDATE mysql.user SET plugin='mysql_native_password' WHERE user='root';
FLUSH PRIVILEGES;
CREATE DATABASE lemp;
CREATE TABLE lemp.users(id INTEGER PRIMARY KEY AUTO_INCREMENT, name VARCHAR(100));

