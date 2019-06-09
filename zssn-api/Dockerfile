FROM ruby:2.6.3
RUN apt-get update -y && \ 
  apt-get install -y build-essential libpq-dev nodejs && \
  mkdir /zombie_app

WORKDIR /zombie_app
ADD Gemfile /zombie_app/Gemfile
ADD Gemfile.lock /zombie_app/Gemfile.lock
RUN bundle install
ADD . /zombie_app

EXPOSE 3000
CMD ["bundle", "exec", "rails", "s", "-p", "3000", "-b", "0.0.0.0"] 