FROM ruby:2.6.3-alpine3.10

RUN apk --update add imagemagick

COPY . /src
WORKDIR /src

RUN bundle

CMD ["ruby", "entrypoint.rb"]
