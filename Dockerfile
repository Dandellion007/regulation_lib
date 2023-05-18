FROM ruby:3.1.3

# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
#   && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
#   && apt-get update -qq && apt-get install -y yarn \

WORKDIR /app

RUN apt-get update -qq && apt-get install -y npm \
  && npm install -g yarn && npm install -y node@20 \
  && yarn add webpack bootstrap jquery popper.js

ENV BUNDLER_VERSION=2.4
RUN gem install bundler -v 2.4
COPY . .
RUN bundle install
RUN rails webpacker:install
RUN chmod +x ./entrypoints/docker-entrypoint.sh
ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
