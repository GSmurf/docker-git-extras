# docker build -t gismo/docker-git-extras .
# docker run --rm -it -v `pwd`:/app gismo/docker-git-extras

FROM alpine:3 AS build

ARG GIT_BRANCH=-
ARG GIT_TAG=-
ARG GIT_COMMIT_HASH=NULL

ENV GIT_BRANCH=${GIT_BRANCH} \
	GIT_TAG=${GIT_TAG} \
	GIT_COMMIT_HASH=${GIT_COMMIT_HASH} \
	WORKDIR=/app

RUN apk add --no-cache \
    git \
    bash \
    openssh-client \
    rsync \
    ncurses \
    make

RUN git clone https://github.com/tj/git-extras.git && \
  cd git-extras && \
  cd git-extras; git checkout $(git describe --tags 4.7.0) && \
  cd git-extras ; make install PREFIX=/usr/local

WORKDIR $WORKDIR

CMD git summary
