FROM ruby:alpine

RUN apk add --update build-base

ARG USER=app
ARG GROUP=app
ARG UID=1101
ARG GID=1101

RUN addgroup $GROUP -g $GID
RUN adduser -S $USER -u $UID $GROUP

RUN mkdir -p /var/app
RUN chown -R $USER:$GROUP /var/app

USER $USER
WORKDIR /var/app

COPY --chown=$USER . /var/app

COPY --chown=$USER Gemfile* /var/app/
RUN bundle install

CMD ["bundle", "exec", "rspec", "spec"]
