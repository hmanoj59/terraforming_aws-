FROM ubuntu:14.04

# Install dependencies
RUN apt-get update -y
RUN apt-get install -y wget
RUN apt-get install -y apache2
RUN apt-get install -y python-pip
RUN pip install boto3

RUN wget https://s3.amazonaws.com/naga-hota/python_ecs_worker.py

CMD [ "python", "python_ecs_worker.py" ]

# Install apache and write hello world message
RUN echo "Hello, This is a docker Image created for atom wise test" > /var/www/index.html


# Configure apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80
