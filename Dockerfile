FROM ruby:3.1.2

RUN apt-get update -qq && apt-get install -y build-essential

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

COPY rubyEntryPoint.sh /usr/bin/
RUN chmod +x /usr/bin/rubyEntryPoint.sh
ENTRYPOINT ["rubyEntryPoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
