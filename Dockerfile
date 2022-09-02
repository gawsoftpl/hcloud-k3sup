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

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +X kubectl \
    && mv kubectl /usr/bin
    
RUN wget -O sops https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux.amd64 \
    && chmod +x sops \
    && mv sops /usr/bin    

RUN wget -O age.tar.gz https://github.com/FiloSottile/age/releases/download/v1.0.0/age-v1.0.0-linux-amd64.tar.gz \
    && tar -xvf age.tar.gz \
    && chmod +x age/age* \
    && mv age/age* /usr/bin
    
RUN rm *.tar.gz

COPY cloudflare-* ./
RUN chmod +x cloudflare-* \
    && mv cloudflare-dns-add.sh /usr/bin/cloudflare-dns-add \
    && mv cloudflare-dns-remove.sh /usr/bin/cloudflare-dns-remove

COPY cypress-register-runner /usr/bin/
RUN chmod +x /usr/bin/cypress-register-runner

COPY hcloud-* /usr/bin/

WORKDIR /hcloud-k3s

USER appuser


ENTRYPOINT [ "hcloud-k3sup" ]