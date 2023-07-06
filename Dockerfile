FROM ubuntu:latest
MAINTAINER wangrongxiang

RUN apt-get update && \
    apt-get upgrade && \
    apt-get install -y curl sudo && \
    sudo apt-get install -y ssh libevent-dev libcurl4-openssl-dev libglib2.0-dev uuid-dev intltool && \
    sudo apt-get install -y libsqlite3-dev libmysqlclient-dev libarchive-dev libtool libjansson-dev valac libfuse-dev && \
    sudo apt-get install -y cmake re2c flex sqlite3 python-pip git libssl-dev libldap2-dev libonig-dev vim vim-scripts && \
    sudo apt-get install -y wget gcc autoconf automake mysql-client librados-dev libxml2-dev curl telnet && \
    sudo apt-get install -y netcat unzip netbase ca-certificates apt-transport-https build-essential libxslt1-dev libffi-dev && \
    sudo apt-get install -y libpcre3-dev zlib1g-dev xz-utils nginx pkg-config poppler-utils libmemcached-dev libjwt-dev \
WORKDIR ~/dev/source-code
COPY . ~/dev/source-code/seafile-server
COPY ~/dev/source-code ~/dev/source-code

WORKDIR ~/dev/source-code/libevhtp
RUN sudo make install && sudo ldconfig

WORKDIR ~/dev/source-code/libsearpc
RUN sudo make install && sudo ldconfig

WORKDIR ~/dev/source-code/seafile-server
RUN sudo make install && sudo ldconfig

EXPOSE 8000

ENTRYPOINT ["seaf-server" "-c" "~/dev/conf" "-d" "~/dev/seafile-data" "-D" "all" "-f" "-l" "-" "&"]