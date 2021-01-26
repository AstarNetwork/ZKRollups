#!/bin/bash

cmd="$@"

until curl substrate:5000/prover_data; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"
exec $cmd
