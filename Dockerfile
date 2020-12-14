FROM ruby:2-alpine

RUN apk --update add imagemagick libpng libwebp

COPY ./src/fasd_bot/ /src
WORKDIR /src

RUN bundle

CMD ["ruby", "entrypoint.rb"]
