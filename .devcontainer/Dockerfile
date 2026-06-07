FROM ubuntu:26.04

ARG USERNAME
ARG USER_UID
ARG USER_GID=$USER_UID

ENV DEBIAN_FRONTEND=noninteractiv

RUN userdel -r ubuntu \
  && groupadd -g ${USER_GID} ${USERNAME} \
  && useradd -u ${USER_UID} -g ${USER_GID} -m -s /bin/bash ${USERNAME}

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    locales \
    openssh-client \
    postgresql-client-18 \
    unzip

RUN locale-gen en_US.UTF-8 \
  && update-locale LANG=en_US.UTF-8

ENV LANG=en_US.utf8

RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash

RUN apt-get update \
  && apt-get install -y nodejs \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${USERNAME}

RUN mkdir ~/.npm-global && npm config set prefix '~/.npm-global'
ENV PATH=~/.npm-global/bin:$PATH

RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION}
RUN mkdir ~/.claude

ENV DEBIAN_FRONTEND=
