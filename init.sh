#!/usr/bin/env bash
sleep 10
rails db:create
rails db:migrate
rails db:seed
bundle exec rails s -p 7000 -b '0.0.0.0'
