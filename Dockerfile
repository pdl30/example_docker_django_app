FROM python:3.6

ENV PYTHONUNBUFFERED 1
#ENV DJANGO_ENV dev
#ENV DOCKER_CONTAINER 1

ENV http_proxy=http://10.101.112.70:8080
ENV https_proxy=http://10.101.112.70:8080

COPY ./requirements.txt /code/requirements.txt
RUN pip install -r /code/requirements.txt

COPY . /code/
WORKDIR /code/

EXPOSE 8000