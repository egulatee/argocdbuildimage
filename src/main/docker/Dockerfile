FROM alpine:3.15
COPY bootstrap.sh /var/run/bootstrap.sh
RUN chmod +x /var/run/bootstrap.sh

RUN apk update && apk add git
ENTRYPOINT [ "/var/run/bootstrap.sh" ]
