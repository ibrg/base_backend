#!/bin/sh

until cd /www/src
do
    echo "Waiting for server volume..."
done

until python manage.py makemigrations && python manage.py migrate
do
    echo "Waiting for db to be ready..."
    sleep 2
done


uv run python manage.py collectstatic --noinput

# python manage.py createsuperuser --noinput

uv run gunicorn conf.wsgi --bind 0.0.0.0:8000 --workers 4 --threads 4

# for debug
#python manage.py runserver 0.0.0.0:8000
