#!/bin/bash

echo "nameserver 192.168.122.1" > /etc/resolv.conf # IP DNS

apt-get update  

# nomor 8
# konfigurasi web server
## instalasi Apache
apt-get install apache2 -y 
service apache2 start

# instalasi PHP
apt-get install php -y
apt-get install libapache2-mod-php7.0 -y

service apache2 
apt-get install ca-certificates openssl -y
apt-get install unzip -y
apt-get install git -y

git clone https://github.com/warrenpolandra/Jarkom-Modul-2-D11-2022.git
unzip -o /root/Jarkom-Modul-2-D11-2022/\*.zip -d /root/Jarkom-Modul-2-D11-2022

# webserver
echo " <VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/wise.d11.com
        ServerName wise.d11.com
        ServerAlias www.wise.d11.com

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/wise.d11.com.conf

a2ensite wise.d11.com
mkdir /var/www/wise.d11.com
cp -r /root/Jarkom-Modul-2-D11-2022/wise/. /var/www/wise.d11.com
service apache2 restart

# nomor 9
# index.pho => home
a2enmod rewrite
service apache2 restart
echo "RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule (.*) /index.php/\$1 [L]" > /var/www/wise.d11.com/.htaccess

echo "<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/wise.d11.com
        ServerName wise.d11.com
        ServerAlias www.wise.d11.com

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/wise.d11.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>" > /etc/apache2/sites-available/wise.d11.com.conf

service apache2 restart

# nomor 10
# konfigurasi subdomain www.eden.wise.d11.com
echo "<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.d11.com
        ServerName eden.wise.d11.com
        ServerAlias www.eden.wise.d11.com

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/wise.d11.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>" > /etc/apache2/sites-available/eden.wise.d11.com.conf

a2ensite eden.wise.d11.com
mkdir /var/www/eden.wise.d11.com
cp -r /root/Jarkom-Modul-2-D11-2022/eden.wise/. /var/www/eden.wise.d11.com
service apache2 restart
echo "<?php echo 'nomor 10' ?>" > /var/www/eden.wise.d11.com/index.php

# nomor 11 
echo "<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.d11.com
        ServerName eden.wise.d11.com
        ServerAlias www.eden.wise.d11.com

        <Directory /var/www/eden.wise.d11.com/public>
                Options +Indexes
        </Directory>

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/wise.d11.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>" > /etc/apache2/sites-available/eden.wise.d11.com.conf
service apache2 restart

# nomor 12
# error file
echo "<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.d11.com
        ServerName eden.wise.d11.com
        ServerAlias www.eden.wise.d11.com

        ErrorDocument 404 /error/404.html
        ErrorDocument 500 /error/404.html
        ErrorDocument 502 /error/404.html
        ErrorDocument 503 /error/404.html
        ErrorDocument 504 /error/404.html

        <Directory /var/www/eden.wise.d11.com/public>
                Options +Indexes
        </Directory>

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/wise.d11.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>" > /etc/apache2/sites-available/eden.wise.d11.com.conf
service apache2 restart

# konfigurasi virtual host (no. 13)
echo "<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.d11.com
        ServerName eden.wise.d11.com
        ServerAlias www.eden.wise.d11.com

        ErrorDocument 404 /error/404.html
        ErrorDocument 500 /error/404.html
        ErrorDocument 502 /error/404.html
        ErrorDocument 503 /error/404.html
        ErrorDocument 504 /error/404.html

        <Directory /var/www/eden.wise.d11.com/public>
                Options +Indexes
        </Directory>

        Alias \"/js\" \"/var/www/eden.wise.d11.com/public/js\"


        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/wise.d11.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>
" > /etc/apache2/sites-available/eden.wise.d11.com.conf
service apache2 restart

# konfigurasi virtual host 15000 dan 15500 (no. 14)
echo "<VirtualHost *:15000>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/strix.operation.wise.d11.com
        ServerName strix.operation.wise.d11.com
        ServerAlias www.strix.operation.wise.d11.com


        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

<VirtualHost *:15500>        
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/strix.operation.wise.d11.com
        ServerName strix.operation.wise.d11.com
        ServerAlias www.strix.operation.wise.d11.com
        

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/strix.operation.wise.d11.com.conf

a2ensite strix.operation.wise.d11.com
service apache2 restart
mkdir /var/www/strix.operation.wise.d11.com
cp -r /root/Jarkom-Modul-2-D11-2022/strix.operation.wise/. /var/www/strix.operation.wise.d11.com/
echo "<?php echo 'nomor 14';?>" > /var/www/strix.operation.wise.d11.com/index.php
echo "# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80
Listen 15000
Listen 15500
<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>" > /etc/apache2/ports.conf
service apache2 restart

# autentikasi username Twilight pass opStrix
htpasswd -c -b /etc/apache2/.htpasswd Twilight opStrix

echo "<VirtualHost *:15000>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/strix.operation.wise.d11.com
        ServerName strix.operation.wise.d11.com
        ServerAlias www.strix.operation.wise.d11.com

        <Directory \"/var/www/strix.operation.wise.d11.com\">
                AuthType Basic
                AuthName \"Restricted Content\"
                AuthUserFile /etc/apache2/.htpasswd
                Require valid-user
        </Directory>

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
<VirtualHost *:15500>        
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/strix.operation.wise.d11.com
        ServerName strix.operation.wise.d11.com
        ServerAlias www.strix.operation.wise.d11.com
        
        <Directory \"/var/www/strix.operation.wise.d11.com\">
                AuthType Basic
                AuthName \"Restricted Content\"
                AuthUserFile /etc/apache2/.htpasswd
                Require valid-user
        </Directory>
        
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/strix.operation.wise.d11.com.conf
service apache2 restart

# IP Eden -> www.wise.d11.com
echo "<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        RewriteEngine On
        RewriteCond %{HTTP_HOST} !^wise.d11.com$
        RewriteRule /.* http://wise.d11.com/ [R]

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

</VirtualHost>" > /etc/apache2/sites-available/000-default.conf
service apache2 restart

# request gambar (no. 17)
echo "RewriteEngine On
RewriteCond %{REQUEST_URI} ^/public/images/(.*)eden(.*)
RewriteCond %{REQUEST_URI} !/public/images/eden.png
RewriteRule /.* http://eden.wise.d11.com/public/images/eden.png [L]" > /var/www/eden.wise.d11.com/.htaccess

echo "<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.d11.com
        ServerName eden.wise.d11.com
        ServerAlias www.eden.wise.d11.com

        ErrorDocument 404 /error/404.html
        ErrorDocument 500 /error/404.html
        ErrorDocument 502 /error/404.html
        ErrorDocument 503 /error/404.html
        ErrorDocument 504 /error/404.html

        <Directory /var/www/eden.wise.d11.com/public>
                Options +Indexes
        </Directory>

        Alias \"/js\" \"/var/www/eden.wise.d11.com/public/js\"

        <Directory /var/www/eden.wise.d11.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/wise.d11.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>" > /etc/apache2/sites-available/eden.wise.d11.com.conf

# Restart web server
service apache2 restart
