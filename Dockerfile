FROM ruby:2.4-alpine AS base

RUN mkdir /app
RUN mkdir /app/bot

WORKDIR /app/bot

COPY ./ /app/bot

RUN apk update && apk add  --no-cache git make gcc libc-dev

ENV SPEC_PATH=$SPEC_PATH

RUN gem install bundler thor
# RUN bundle install --path=/app/bot
RUN bundle install



RUN bundle exec thor install lib/cli.thor --as botspec --force 



CMD ["bundle", "exec", "thor", "cli", "--dialogs="]
# CMD sh
