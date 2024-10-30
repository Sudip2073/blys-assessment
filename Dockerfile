FROM wordpress:latest

ENV WORDPRESS_DB_HOST=db:3306 \
    WORDPRESS_DB_USER=wordpress \
    WORDPRESS_DB_PASSWORD=wordpress_password \
    WORDPRESS_DB_NAME=wordpress


# COPY ./plugins /var/www/html/wp-content/plugins/
# COPY ./themes /var/www/html/wp-content/themes/

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["apache2-foreground"]
