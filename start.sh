#!/bin/bash
bundle check || bundle install
gem install solargraph
bundle exec rails s -p 3030 -b 0.0.0.0