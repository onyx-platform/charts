FROM alpine:3.6 as build
MAINTAINER Gardner Vickers <gardner@vickers.me>

RUN apk add --update --no-cache ca-certificates git

ARG VERSION=v2.6.1
ENV FILENAME helm-${VERSION}-linux-amd64.tar.gz

RUN apk add --update -t deps curl tar gzip
RUN curl -L http://storage.googleapis.com/kubernetes-helm/${FILENAME} | tar zxv -C /tmp

# The image we keep
FROM alpine:3.6

COPY --from=build /tmp/linux-amd64/helm /bin/helm
RUN apk add --no-cache ca-certificates git openssh bash curl
RUN helm init --client-only
RUN helm plugin install https://github.com/databus23/helm-diff
RUN helm plugin install https://github.com/gardnervickers/helm-bump

ENTRYPOINT ["/bin/helm"]
