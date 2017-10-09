FROM alpine:3.6 as build
MAINTAINER Gardner Vickers <gardner@vickers.me>

RUN apk add --update --no-cache ca-certificates git

ENV VERSION v2.6.1
ENV FILENAME helm-${VERSION}-linux-amd64.tar.gz

WORKDIR /

RUN apk add --update -t deps curl tar gzip
RUN curl -L http://storage.googleapis.com/kubernetes-helm/${FILENAME} | tar zxv -C /tmp

# The image we keep
FROM alpine:3.6

COPY --from=build /tmp/linux-amd64/helm /bin/helm
RUN apk add --no-cache ca-certificates
RUN apk add --no-cache git
RUN apk add --no-cache openssh

ENTRYPOINT ["/bin/helm"]
