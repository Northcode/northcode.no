#!/bin/sh

python3 manage.py migrate
python3 manage.py collectstatic

echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('$DJANGO_SUPERUSER', '$DJANGO_SUEMAIL', '$DJANGO_SUPASS')" | python3 manage.py shell

uwsgi --plugin /usr/lib/uwsgi/python3_plugin.so --http-socket :$WSGI_PORT --module northcode.wsgi:application --static-map /static=static/
