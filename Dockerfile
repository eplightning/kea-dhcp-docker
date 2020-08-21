FROM ubuntu:focal

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y locales iputils-ping \
        kea-admin kea-ctrl-agent kea-dhcp-ddns-server kea-dhcp4-server kea-dhcp6-server \
        dumb-init supervisor postgresql-client mysql-client && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

COPY ./assets /kea/assets
RUN mkdir /kea/config && mkdir /run/kea

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/kea/assets/entrypoint.sh"]

CMD []
