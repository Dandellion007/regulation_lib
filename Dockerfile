# # syntax=docker/dockerfile:1
# FROM ruby:2.5
# RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
# WORKDIR /myapp
# COPY Gemfile /myapp/Gemfile
# COPY Gemfile.lock /myapp/Gemfile.lock
# RUN bundle install
# # Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000
# # Configure the main process to run when running the image
# CMD ["rails", "server", "-b", "0.0.0.0"]

FROM ruby:3.0.0
ENV BUNDLER_VERSION=2.4
RUN gem install bundler -v 2.4
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install 
COPY . .
RUN chmod +x ./entrypoints/docker-entrypoint.sh
ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
