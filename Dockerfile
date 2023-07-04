ARG RUBY_VERSION=3.1.3

FROM ruby:$RUBY_VERSION AS base

RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    apt-utils \
    build-essential \
    bzip2 \
    curl \
    debian-archive-keyring \
    git \
    libjemalloc2 \
    libpq-dev \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

RUN mkdir -p /app
WORKDIR /app

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=$(nproc) \
  BUNDLE_RETRY=3

EXPOSE 3000

RUN gem update --system \
  && gem install bundler rubygems-bundler

ENV RAILS_ENV=production

COPY Gemfile* ./
RUN bundle config set without "test development" \
  && bundle install --quiet \
  && gem regenerate_binstubs

COPY . .

CMD ["./bin/rails", "s", "-b", "0.0.0.0", "-p", "3000"]