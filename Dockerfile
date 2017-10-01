FROM bluekiri/alpine-opencv-microimage

MAINTAINER David Verdejo <david.verdejo@bluekiri.com>

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk update && \
    apk add --update --no-cache \
	curl-dev \
	zlib-dev \
	jpeg-dev \
	openssl-dev && \
    rm -rf /var/cache/apk/* && \
    pip install --use-wheel --no-cache-dir \
	envtpl==0.5.3 \
	pyremotecv==0.5.0 \
	remotecv==2.2.1 \
	opencv-engine==1.0.1 \
	thumbor==6.3.2 
        #http://thumbor.readthedocs.io/en/latest/plugins.html

ENV HOME /usr/src/app
ENV SHELL bash
ENV WORKON_HOME /usr/src/app
WORKDIR /usr/src/app

COPY conf/thumbor.conf.tpl /usr/src/app/thumbor.conf.tpl
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["thumbor"]

EXPOSE 8000
