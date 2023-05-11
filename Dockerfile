FROM ruby:3.1.3

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq && apt-get install -y yarn

ENV BUNDLER_VERSION=2.4
RUN gem install bundler -v 2.4
WORKDIR /app
COPY . .
RUN bundle check || bundle install
RUN rails webpacker:install 
RUN chmod +x ./entrypoints/docker-entrypoint.sh
ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
