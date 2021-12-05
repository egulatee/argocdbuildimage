FROM alpine:3.15
COPY bootstrap.sh /var/run/bootstrap.sh
RUN chmod +x /var/run/bootstrap.sh

RUN apk update && apk add git openssh coreutils jq curl

#Install argocd cli
RUN curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
RUN chmod +x /usr/local/bin/argocd

# To troubleshoot
RUN apk update && apk add findutils

ENTRYPOINT [ "/var/run/bootstrap.sh" ]