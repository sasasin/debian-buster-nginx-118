FROM debian:buster

RUN echo '\n\
deb http://deb.debian.org/debian/ testing main\n\
deb-src http://deb.debian.org/debian/ testing main\n\
' > /etc/apt/sources.list.d/testing.list

RUN echo '\n\
Package: *\n\
Pin: release a=stable\n\
Pin-Priority: 900\n\
\n\
Package: *\n\
Pin: release a=testing\n\
Pin-Priority: 99\n\
\n\
Package: *\n\
Pin: release a=unstable\n\
Pin-Priority: 89\n\
' >> /etc/apt/preferences

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt install -y --allow-remove-essential \
        libnginx-mod-http-headers-more-filter/testing \
        nginx-core/testing \
        nginx-common/testing \
        libnginx-mod-http-xslt-filter/testing \
        libnginx-mod-mail/testing \
        libnginx-mod-stream/testing \
        libnginx-mod-stream-geoip/testing \
        libcrypt1/testing \
        libc6/testing \
        libc-bin/testing

RUN /usr/sbin/nginx -h
RUN /usr/sbin/nginx -V

RUN sed -ie "26a more_clear_headers Server;" /etc/nginx/nginx.conf

RUN cat -n /etc/nginx/nginx.conf
RUN ls -alF /etc/nginx/modules-enabled/*.conf
RUN cat /usr/share/nginx/modules-available/mod-http-headers-more-filter.conf

WORKDIR /

EXPOSE 80
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
