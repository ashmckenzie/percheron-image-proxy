FROM gliderlabs/alpine:latest
MAINTAINER ash@the-rebellion.net

ENV APP_HOME {{ userdata.app.home }}
ENV GOPATH {{ userdata.app.gopath }}

ADD ./config/repositories /etc/apk/repositories

RUN apk add --update-cache bash openssl-dev ca-certificates tzdata wget go@edge
RUN apk add --update-cache git
RUN go get willnorris.com/go/imageproxy/cmd/imageproxy
RUN go get github.com/ddollar/forego

RUN mkdir -p ${APP_HOME} {{ userdata.app.cache_path }}

WORKDIR ${APP_HOME}
ADD ./config/Procfile ./Procfile

ADD ./config/start /start
RUN chmod 755 /start

EXPOSE {{ userdata.app.internal_port }}

CMD [ "/start" ]
