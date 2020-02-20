FROM ruby:latest

#RUN bundle config --global frozen 1
WORKDIR /app
COPY . ./

RUN bundle install

CMD ["./entrypoint.sh"]
