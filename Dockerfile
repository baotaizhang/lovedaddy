FROM ruby:2.5.1

ENV APP_ROOT=/usr/src/app/
ENV LANG C.UTF-8

WORKDIR $APP_ROOT

# ベースバッケージをインストール
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    curl \
    apt-transport-https \
    wget \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# yarn パッケージ管理ツールインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Node.js インストール
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install nodejs

COPY Gemfile Gemfile.lock $APP_ROOT

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bundle install && \
  rm -rf ~/.gem

ENV PATH /usr/local/bundle/bin:$PATH

COPY . $APP_ROOT

EXPOSE 3000
