<VirtualHost *:80>
  ServerName marilyn.23inhouse.com
  ServerAlias *.marilyn.23inhouse.com

  # RailsEnv staging # for Rails 2
  RackEnv staging

  DocumentRoot /home/carlo/public_html/glamor_mommy_staging/current/public
  <Directory /home/carlo/public_html/glamor_mommy_staging/current/public>
     AllowOverride all
     Options -MultiViews
  </Directory>

  RewriteEngine On

  # send www to non-www
  RewriteCond %{HTTP_HOST} ^www\.marilyn\.23inhouse\.com
  RewriteRule (.*) http://marilyn.23inhouse.com$1 [R=301,L]

  # Custom log file locations
  ErrorLog  /home/carlo/public_html/glamor_mommy_staging/shared/log/error.log
  CustomLog /home/carlo/public_html/glamor_mommy_staging/shared/log/access.log combined

</VirtualHost>
