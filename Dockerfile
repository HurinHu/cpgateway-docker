from ubuntu:22.10

RUN apt-get update \
 && apt-get install -yq --no-install-recommends \
    wget \
    ca-certificates \
    sudo \
    locales \
    openjdk-18-jdk \
    unzip


RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Configure environment
ENV SHELL=/bin/bash \
    NB_USER=$NB_USER \
    NB_UID=$NB_UID \
    NB_GID=$NB_GID \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

ENV TZ=Pacific/Auckland
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY clientportal.gw.zip /clientportal.gw.zip
RUN unzip /clientportal.gw.zip -d /clientportal
COPY conf.yaml /clientportal/root/conf.yaml
COPY start /clientportal
WORKDIR /clientportal
CMD ["./start"]
