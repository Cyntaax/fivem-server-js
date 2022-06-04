FROM ubuntu:22.04

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt upgrade -y

RUN apt install ca-certificates curl gettext git gnupg xz-utils -y

RUN curl -sL https://deb.nodesource.com/setup_16.x  | bash -

RUN apt install nodejs

RUN mkdir -p /opt

WORKDIR /opt

COPY fx-artifact-getter ./fx-artifact-getter

RUN cd /opt/fx-artifact-getter && npm i

ARG FX_VER="5104"

RUN cd ./fx-artifact-getter && npm run download ${FX_VER}

RUN tar -xvf ./fx-artifact-getter/fx.tar.xz -C /srv

RUN mkdir -p /srv/resources

COPY "./resources/package.json" /srv/resources/package.json

RUN cd /srv/resources && npm install

WORKDIR /srv

ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_DB
ARG MYSQL_HOST
ARG RCON_PASS
ARG BANNER_DETAIL
ARG BANNER_CONNECTING
ARG SV_HOSTNAME
ARG STEAM_KEY
ARG SV_MAXCLIENTS
ARG ADMIN_ID
ARG SV_LICENSEKEY

COPY cfg/dev/template.server.cfg .

RUN envsubst < template.server.cfg > server.cfg

COPY ./wait .

RUN chmod +x ./wait

CMD ./wait && sh /srv/run.sh  +exec server.cfg
