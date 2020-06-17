#!/bin/bash

sysbench --db-driver=mysql --mysql-host=database-2**.com --mysql-port=3306 --mysql-user=admin --mysql-password=password --mysql-db=foo --range_size=100  --table_size=1000000 --tables=1 --threads=1 --events=0 --time=60 --rand-type=uniform ./src/lua/oltp_update_non_index.lua  prepare

for i in 1 2 4 8 16 32 64 128 256 512
do
  echo running test for $i threads
  sysbench --db-driver=mysql --mysql-host=data*********-1.rds.amazonaws.com --mysql-port=3306 --mysql-user=admin --mysql-password=password --mysql-db=foo  --table_size=1000000 --tables=1 --threads=$i --time=60 --rand-type=uniform ./src/lua/oltp_update_non_index.lua  run > file_$i.txt
  echo "cooling down for half a minute."
  sleep 30
done
