FROM ruby:2-alpine

RUN apk --update add imagemagick libpng libwebp

WORKDIR /src
COPY ./src/ .

RUN bundle

ENTRYPOINT ["ruby", "entrypoint.rb"]
