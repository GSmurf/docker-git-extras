# docker build -t gismo/docker-git-extras .
# docker run --rm -it -v `pwd`:/app gismo/docker-git-extras

FROM alpine:3 AS build

ARG GIT_BRANCH=-
ARG GIT_TAG=-
ARG GIT_COMMIT_HASH=NULL

ENV VER_GIT_EXTRA=6.3.0 \
	GIT_BRANCH=${GIT_BRANCH} \
	GIT_TAG=${GIT_TAG} \
	GIT_COMMIT_HASH=${GIT_COMMIT_HASH} \
	WORKDIR=/app

RUN apk add --no-cache \
    git \
    bash \
    openssh-client \
    rsync \
    ncurses \
    make \
    util-linux

RUN git clone https://github.com/tj/git-extras.git && \
  cd git-extras && \
  cd git-extras; git checkout $(git describe --tags \${VER_GIT_EXTRA) && \
  cd git-extras ; make install PREFIX=/usr/local && \
  cd .. ; rm -rf git-extras

WORKDIR $WORKDIR

CMD git summary
