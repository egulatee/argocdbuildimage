FROM alpine:3.15
COPY bootstrap.sh /var/run/bootstrap.sh
RUN chmod +x /var/run/bootstrap.sh

RUN apk update && apk add git coreutils
ENTRYPOINT [ "/var/run/bootstrap.sh" ]
