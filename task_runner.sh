#!/bin/bash
export RBENV_ROOT="/Users/chiaki/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"
cd /Users/chiaki/portfolio/goshichide
RBENV_VERSION=3.2.2 RAILS_ENV=development /Users/chiaki/.rbenv/shims/bundle exec rake senryu:send_ranking --silent >> /Users/chiaki/portfolio/goshichide/log/cron.log 2>&1
