FROM ruby:2.4.2-slim

LABEL net.skyplabs.maintainer-name="Paul-Emmanuel Raoul"
LABEL net.skyplabs.maintainer-email="skyper@skyplabs.net"

EXPOSE 4000

ENV LC_ALL=C.UTF-8

RUN apt-get update \
	&& apt-get install -y --no-install-recommends gcc g++ make patch curl apt-transport-https \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs yarn

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app
COPY Gemfile.lock /usr/src/app

RUN bundle install \
    && rm -f Gemfile Gemfile.lock

CMD ["jekyll", "serve", "--host", "0.0.0.0", "--watch", "--drafts", "--future"]
