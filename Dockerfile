FROM ruby:2.6.3-alpine3.10

RUN apk --update add imagemagick libpng libwebp

COPY ./src/fasd_bot/ /src
WORKDIR /src

RUN bundle

CMD ["ruby", "entrypoint.rb"]
