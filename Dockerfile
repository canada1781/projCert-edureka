FROM devopsedu/webapp

COPY ./php_website_code/ /var/www/html/

EXPOSE 80

CMD ["apache2-foreground"]
