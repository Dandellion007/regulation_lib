FROM ruby:3.1.3

# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
#   && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
#   && apt-get update -qq && apt-get install -y yarn

RUN apt-get update -qq && apt-get install -y npm \
  && npm install -g node@20.2.0 yarn

ENV BUNDLER_VERSION=2.4
RUN gem install bundler -v 2.4

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json yarn.lock ./
RUN yarn install
# RUN yarn install --check-files

COPY . ./ 

##################
# RUN bundle exec rails --trace db:create \
#   && bundle exec rails db:migrate

# RUN chmod +x ./entrypoints/docker-entrypoint.sh \
#   && chmod +x ./bin/dev

##################
ENTRYPOINT [ "./bin/dev" ]
# ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
