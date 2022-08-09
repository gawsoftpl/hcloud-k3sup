FROM alpine

RUN apk update && apk add openssh curl bash jq

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

RUN wget -O k3sup https://github.com/alexellis/k3sup/releases/download/0.12.0/k3sup \
    && chmod +x k3sup \
    && mv k3sup /usr/bin/k3sup

RUN wget -O hcloud.tar.gz https://github.com/hetznercloud/cli/releases/download/v1.30.2/hcloud-linux-amd64.tar.gz \
    && tar -xvf hcloud.tar.gz \
    && chmod +x hcloud \
    && mv hcloud /usr/bin/hcloud

WORKDIR /hcloud-k3s

USER appuser

COPY hcloud-* /usr/bin/

ENTRYPOINT [ "hcloud-k3sup" ]