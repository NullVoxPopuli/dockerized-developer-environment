# Inspiration: https://github.com/cmiles74/docker-vscode/blob/master/Dockerfile

# dotnet core + sdk
FROM microsoft/dotnet:2.0.7-sdk-2.1.105

# need these before we can do anything
ENV CORE_DEPS curl wget apt-transport-https tar
RUN apt update && apt install -y $CORE_DEPS

ENV GENERAL_DEPS \
  build-essential \
  libc6-dev libgtk2.0-0 libgtk-3-0 \
  libpango-1.0-0 libcairo2 libfontconfig1 libgconf2-4 \
  libnss3 libasound2 libxtst6 unzip libglib2.0-bin \
  libcanberra-gtk-module libgl1-mesa-glx \
  gettext libstdc++6 software-properties-common \
  automake libtool autogen \
  libnotify-bin aspell aspell-en \
  mono-complete gvfs-bin \
  libxss1 \
  rxvt-unicode-256color x11-xserver-utils \
  libxkbfile1  \
  sudo \
  git

ENV SDKS mono-complete
ENV EDITORS vim code atom

# Add apt repositories for things
RUN echo \
  && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
  && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
  && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' \
  && curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'

# Install the world!
# - Above Deps
# - nvm - node version manager
# - chruby - ruby version manager
RUN echo \
  && apt update \
  && apt install -y \
    $GENERAL_DEPS \
    $SDKS \
    $EDITORS \
  && wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.9/install.sh | bash \
  && wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz \
  && tar -xzvf chruby-0.3.9.tar.gz \
  && cd chruby-0.3.9 && make install

# create our developer user
COPY developer /developer
RUN echo \
  && groupadd -r developer -g 1000 \
  && useradd -u 1000 -r -g developer -d /developer -s /bin/bash -c "Software Developer" developer \
  && echo "developer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/developer \
  && chown -R developer:developer /developer \
  && fc-cache -f -v \
  && mkdir -p /project

ENV SHELL /bin/bash

WORKDIR /developer

VOLUME ["/developer/.config/Code"]
VOLUME ["/developer/.vscode"]
VOLUME ["/developer/.atom"]
VOLUME ["/developer/.ssh"]
VOLUME ["/project"]

USER developer

ENTRYPOINT ["/developer/bin/start-shell"]
