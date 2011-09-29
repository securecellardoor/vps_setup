<VirtualHost *:80>
  ServerName scd.23inhouse.com
  ServerAlias *.scd.23inhouse.com

  # RailsEnv staging # for Rails 2
  RackEnv staging

  DocumentRoot /home/ben/public_html/secure_cellar_door_staging/current/public
  <Directory /home/ben/public_html/secure_cellar_door_staging/current/public>
     AllowOverride all
     Options -MultiViews
  </Directory>

  RewriteEngine On

  # send www to non-www
  RewriteCond %{HTTP_HOST} ^www\.scd\.23inhouse\.com
  RewriteRule (.*) http://scd.23inhouse.com$1 [R=301,L]

  # Custom log file locations
  ErrorLog  /home/ben/public_html/secure_cellar_door_staging/shared/log/error.log
  CustomLog /home/ben/public_html/secure_cellar_door_staging/shared/log/access.log combined

</VirtualHost>
