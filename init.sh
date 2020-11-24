#!/usr/bin/env bash
rails db:create
rails db:migrate
bundle exec rails s -p 7000 -b '0.0.0.0'
