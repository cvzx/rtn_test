#!/bin/bash

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# wait for the postgres docker to be running
while ! pg_isready -h db -p 5432 -q -U postgres; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

bin/rails db:reset
bin/rails server --port 3000 --binding 0.0.0.0
