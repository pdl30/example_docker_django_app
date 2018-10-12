FROM python:3.6

ENV PYTHONUNBUFFERED 1
#ENV DJANGO_ENV dev
#ENV DOCKER_CONTAINER 1

ENV http_proxy=http://10.101.112.70:8080
ENV https_proxy=http://10.101.112.70:8080

RUN apt-get update
RUN apt-get install -y build-essential software-properties-common
RUN apt-get update
RUN add-apt-repository ppa:webupd8team/java
# RUN add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main"
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated oracle-java8-installer maven \
    python3-dev python3-pip python3-virtualenv \
    libsasl2-dev libldap2-dev libssl-dev
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN apt-get install -y npm
RUN npm install avrodoc -g

RUN mkdir /gel
RUN mkdir /gel/GelReportModels
WORKDIR /gel
ADD GelReportModels /gel/GelReportModels
ADD GelReportModels/m2_settings.xml /gel
RUN mkdir -p ~/.m2 && cp m2_settings.xml ~/.m2/settings.xml
WORKDIR /gel/GelReportModels
RUN pip3 install --upgrade pip==18.0
ENV GEL_REPORT_MODELS_PYTHON_VERSION 3
RUN pip3 install .



COPY ./requirements.txt /code/requirements.txt
RUN pip install -r /code/requirements.txt

COPY . /code/
WORKDIR /code/

EXPOSE 8000