FROM ruby:2.7.1

COPY init.sh /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/init.sh"]

WORKDIR /code

COPY . /code

RUN bundle install

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

RUN yarn install --check-files

ENTRYPOINT []
