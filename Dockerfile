FROM ruby:latest

RUN apt-get update -qq && apt-get install -y postgresql-client
#RUN bundle config --global frozen 1
WORKDIR /app
COPY . ./

RUN bundle install

CMD ["./entrypoint.sh"]
