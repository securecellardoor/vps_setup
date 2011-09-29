<VirtualHost *:80>
  ServerName securecellardoor.com
  ServerAlias *.securecellardoor.com

  # RailsEnv demo # for Rails 2
  RackEnv demo

  DocumentRoot /home/ben/public_html/secure_cellar_door_demo/current/public
  <Directory /home/ben/public_html/secure_cellar_door_demo/current/public>
     AllowOverride all
     Options -MultiViews
  </Directory>

  RewriteEngine On

  # # redirect all traffic to .au
  # RewriteCond   %{HTTP_HOST}   ^securecellardoor.com$   [NC]
  # RewriteRule   ^(.*)$   http://securecellardoor.com.au$1   [R=301,L]
  # 
  # RewriteCond   %{HTTP_HOST}   ^([^.]*).securecellardoor.com$   [NC]
  # RewriteRule   ^(.*)$   http://%1.securecellardoor.com.au$1   [R=301,L]

  # send www to non-www
  RewriteCond %{HTTP_HOST} ^www\.securecellardoor\.com
  RewriteRule (.*) http://securecellardoor.com$1 [R=301,L]

  # # Redirect all cached pages to the cache folder
  # # subdomain-less index page
  # RewriteCond %{REQUEST_METHOD} GET [NC]
  # RewriteCond %{HTTP_HOST} ^securecellardoor\.com$ [NC]
  # RewriteCond %{DOCUMENT_ROOT}/cache/%{REQUEST_URI}index.html -f
  # RewriteRule ^([^.]*)$ /cache/$1index.html [L]
  # 
  # # subdomained index pages
  # RewriteCond %{REQUEST_METHOD} GET [NC]
  # RewriteCond %{HTTP_HOST} ^([^.]*)\.securecellardoor\.com$ [NC]
  # RewriteCond %{DOCUMENT_ROOT}/cache/%1/%{REQUEST_URI}index.html -f
  # RewriteRule ^([^.]*)$ /cache/%1/$1index.html [L]
  # 
  # # subdomain-less pages
  # RewriteCond %{REQUEST_METHOD} GET [NC]
  # RewriteCond %{HTTP_HOST} ^securecellardoor\.com$ [NC]
  # RewriteCond %{DOCUMENT_ROOT}/cache/%{REQUEST_URI}.html -f
  # RewriteRule ^([^.]*)$ /cache/$1.html [L]
  # 
  # # subdomained pages
  # RewriteCond %{REQUEST_METHOD} GET [NC]
  # RewriteCond %{HTTP_HOST} ^([^.]*)\.securecellardoor\.com$ [NC]
  # RewriteCond %{DOCUMENT_ROOT}/cache/%1/%{REQUEST_URI}.html -f
  # RewriteRule ^([^.]*)$ /cache/%1/$1.html [L]

  # Custom log file locations
  ErrorLog  /home/ben/public_html/secure_cellar_door_demo/shared/log/error.log
  CustomLog /home/ben/public_html/secure_cellar_door_demo/shared/log/access.log combined

</VirtualHost>

