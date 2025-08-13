# Base image
FROM ubuntu:24.04

ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV}

ARG RAILS_ENV
ENV RAILS_ENV=${RAILS_ENV}

ARG BUNDLE_DEPLOYMENT
ENV BUNDLE_DEPLOYMENT=${BUNDLE_DEPLOYMENT}

ARG BUNDLE_WITHOUT
ENV BUNDLE_WITHOUT=${BUNDLE_WITHOUT}

# Create app directory
ENV APP_DIR /app
WORKDIR $APP_DIR

# Install system dependencies
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y sudo build-essential software-properties-common wget curl htop git vim tmux net-tools openssl zip unzip tar

# Set TimeZone
ENV TZ Etc/UTC
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata
RUN sudo ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && sudo dpkg-reconfigure -f noninteractive tzdata

# Set Locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN sudo apt-get -y install locales
RUN sudo locale-gen $LANG
RUN sudo update-locale LANG=$LANG LANGUAGE=$LANGUAGE LC_ALL=$LC_ALL

# Init git, tmux, vim
COPY .gitconfig .
RUN cp .gitconfig $HOME
RUN git config --global --add safe.directory $APP_DIR
COPY .tmux.conf .
RUN cp .tmux.conf $HOME && echo "if ! [ -n \"\$TMUX\" ]; then\n\texport TERM=xterm-256color\nfi" >> $HOME/.bashrc
COPY .vimrc .
ENV EDITOR vim
RUN cp .vimrc ~/.vimrc
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
RUN echo "y" | vim -c 'PluginInstall' -c 'qa!'

# Install NodeJS v22
RUN sudo apt-get install -y ca-certificates curl gnupg
RUN sudo mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
ENV NODE_MAJOR=22
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
RUN sudo apt-get update
RUN sudo apt-get install nodejs -y

# Install development tools for nodejs to build native addons
RUN sudo apt-get install -y gcc g++ make

# Install Yarn
RUN sudo npm install --global yarn

# Install Ruby v3.4.5
ARG RUBY_VERSION=3.4.5
ENV DEBIAN_FRONTEND=noninteractive
ENV RBENV_ROOT=/opt/rbenv
ENV PATH="${RBENV_ROOT}/bin:${RBENV_ROOT}/shims:${PATH}"
# Use bash login shell so we can eval rbenv easily in this and later RUN lines
SHELL ["/bin/bash", "-lc"]
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl ca-certificates build-essential \
    libssl-dev libreadline-dev zlib1g-dev autoconf bison libyaml-dev \
    libgmp-dev libffi-dev libgdbm-dev \
  && rm -rf /var/lib/apt/lists/* \
  \
  # rbenv + ruby-build
  && git clone --depth 1 https://github.com/rbenv/rbenv.git "${RBENV_ROOT}" \
  && mkdir -p "${RBENV_ROOT}/plugins" \
  && git clone --depth 1 https://github.com/rbenv/ruby-build.git "${RBENV_ROOT}/plugins/ruby-build" \
  && "${RBENV_ROOT}/src/configure" && make -C "${RBENV_ROOT}/src" \
  \
  # Install Ruby and Bundler
  && eval "$(rbenv init -)" \
  && rbenv install "${RUBY_VERSION}" \
  && rbenv global "${RUBY_VERSION}" \
  && gem update --system \
  && gem install bundler \
  && rbenv rehash

# Install Rails
RUN gem install rails -v 8.0.2

# Install Rails dependencies
RUN apt-get update && apt install -y curl gnupg build-essential libssl-dev libreadline-dev zlib1g-dev git libsqlite3-dev sqlite3 libpq-dev libxml2-dev libxslt1-dev libyaml-dev curl libjemalloc2 libvips postgresql-client pkg-config && rm -rf /var/lib/apt/lists/*

# Create a new app
#rails new Tanym \
#  --api \
#  --skip-javascript \
#  --skip-css \
#  --database=postgresql \
#  --skip-git \
#  --skip-decrypted-diffs \
#  --skip-docker \
#  --skip-ci \
#  --skip-action-mailer \
#  --skip-action-mailbox \
#  --skip-action-text \
#  --skip-active-job \
#  --skip-active-storage \
#  --skip-action-cable \
#  --skip-test \
#  --skip-system-test \
#  --skip-bootsnap \
#  --skip-thruster \
#  --skip-kamal \
#  --skip-solid

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

