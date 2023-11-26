FROM devopsedu/webapp

COPY ./website/ /var/www/html/

EXPOSE 80

CMD ["apache2-foreground"]
