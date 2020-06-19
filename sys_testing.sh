#!/bin/bash

sysbench --db-driver=mysql --mysql-host=host --mysql-port=3306 --mysql-user=admin --mysql-password=password--mysql-db=sysbench --range_size=100  --table_size=1000000 --tables=1 --threads=1 --events=0 --time=650 --rand-type=uniform ./src/lua/oltp_read_write.lua  prepare

for i in 2 4 16 64
do
  echo running test for $i threads
  sysbench --db-driver=mysql --mysql-host=host --mysql-port=3306 --mysql-user=admin --mysql-password=password --mysql-db=sysbench  --table_size=1000000 --tables=1 --threads= --time=650 --rand-type=uniform ./src/lua/oltp_read_write.lua  run > aws_$i.txt
  echo "cooling down"
  sleep 10
  
done
