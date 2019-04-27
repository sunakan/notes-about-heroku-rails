# = debianのpostgresql-clientに問題がある
# * CircleCIの記事
# ** https://support.circleci.com/hc/ja/articles/360003953613-Docker-%E3%81%AB-postgresql-client-9-6-%E3%82%92%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%99%E3%82%8B%E9%9A%9B%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC
# * gnupg2はapt-key addのため

FROM ruby:2.6.3-slim-stretch
WORKDIR /app
RUN apt-get update && apt-get install -y wget gnupg2 curl
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main' | tee /etc/apt/sources.list.d/pgdg.list && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && \
  apt-get install -y build-essential patch ruby-dev zlib1g-dev liblzma-dev libpq-dev postgresql-client nodejs
COPY Gemfile* ./
RUN bundle install -j4 --path vendor/bundle
