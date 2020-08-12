FROM ruby:2.7.1
LABEL maintainer="markokoen@gmail.com"
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends apt-transport-https

# Get Node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

# Get Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install packages
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends nodejs
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends yarn

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
# RUN gem install bundler
# RUN bundle update --bundler
RUN bundle install

COPY . /usr/src/app/

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
