#!/bin/bash

set -m

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# запуск основного процесса сервера, из-за "&" он запускается в фоновом режиме
rdbg --open -n -c -- rails s -b 0.0.0.0 -p 3000 &

# "rails db:prepare" проверяет существует ли база, нет -> db:setup, да -> db:migrate
# это нужно для создания баз при самом первом запуске контейнера 
bundle exec rails db:prepare

# возвращает процесс rails s на передний план, чтобы видеть логи 
fg %1

# fg lifehack from https://docs.docker.com/config/containers/multi-service_container/
