FROM alpine:3.15
COPY bootstrap.sh /var/run/bootstrap.sh
RUN chmod +x /var/run/bootstrap.sh

RUN apk update && apk add git coreutils jq

# To troubleshoot
#RUN apk update && apk add findutils

ENTRYPOINT [ "/var/run/bootstrap.sh" ]
