FROM alpine

RUN wget -O k3sup https://github.com/alexellis/k3sup/releases/download/0.12.0/k3sup \
    && chmod +x k3sup \
    && mv k3sup /usr/bin/k3sup

RUN wget -O hcloud.tar.gz https://github.com/hetznercloud/cli/releases/download/v1.30.2/hcloud-linux-amd64.tar.gz \
    && tar -xvf hcloud.tar.gz \
    && chmod +x hcloud \
    && mv hcloud /usr/bin/hcloud

WORKDIR /project

USER 1000

COPY *.sh ./

ENTRYPOINT [ "/bin/sh", "hcloud-k3sup.sh" ]