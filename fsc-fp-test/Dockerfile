FROM alpine:latest
RUN apk add --no-cache --update curl

RUN curl -L -o /usr/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x /usr/bin/kubectl
COPY fp-sc-want.txt fp-sc-want.txt