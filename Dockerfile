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

COPY cloudflare-* ./
RUN chmod +x cloudflare-* \
    && mv cloudflare-dns-add.sh /usr/bin/cloudflare-dns-add \
    && mv cloudflare-dns-remove.sh /usr/bin/cloudflare-dns-remove

WORKDIR /hcloud-k3s

USER appuser

COPY cypress-register-runner /usr/bin
RUN chmod +x /usr/bin/cypress-register-runner

COPY hcloud-* /usr/bin/

ENTRYPOINT [ "hcloud-k3sup" ]