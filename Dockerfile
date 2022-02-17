# https://github.com/tj/git-extras/blob/master/Commands.md#git-changelog
FROM debian:buster-slim

ENV DIR_PROJECT=/data

RUN apt-get update; \
        apt-get install -y --no-install-recommends \
                git \
                git-extras \
        ; \
        rm -rf /var/lib/apt/lists/*

VOLUME ["${DIR_PROJECT}"]

WORKDIR "${DIR_PROJECT}"

CMD ["/usr/bin/git","changelog","--stdout"]
