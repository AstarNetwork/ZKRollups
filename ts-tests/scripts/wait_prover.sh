#!/bin/bash

cmd="$@"

Line=0

while [[ 4 -ge $Line ]]
do
  Line=`psql "postgres://postgres:password@postgres/zksync"  -c "SELECT * from active_provers;" | wc -l`
  >&2 echo "Prover is not working"
  sleep 10
done

>&2 echo "Prover is working"
exec $cmd
