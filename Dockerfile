FROM alpine:latest

RUN apk add uwsgi-python3 
RUN python3 -m ensurepip
RUN pip3 install --upgrade pip setuptools

RUN apk add zlib-dev jpeg-dev build-base musl-dev linux-headers python3-dev

WORKDIR /var/www/northcode.no/
ADD . /var/www/northcode.no/

ENV WSGI_PORT 8080
EXPOSE $WSGI_PORT

RUN pip3 install -r requirements.txt

RUN chmod +x run_uwsgi.sh

ENV DJANGO_SUPERUSER admin
ENV DJANGO_SUEMAIL admin@example.com
ENV DJANGO_SUPASS admin

ENTRYPOINT ["sh", "/var/www/northcode.no/run_uwsgi.sh"]
