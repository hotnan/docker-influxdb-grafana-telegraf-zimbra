#!/bin/bash

docker-compose up -d
sudo chown -R 472:472 ./grafana/data
sudo chown -R 472:472 ./influxdb/data

echo "Grafana: http://127.0.0.1:3000 - admin/admin"

echo
echo "Current database list"
curl -G http://localhost:8086/query?pretty=true --data-urlencode "db=glances" --data-urlencode "q=SHOW DATABASES"

echo
echo "Create a new database ?"
curl -XPOST 'http://localhost:8086/query' --data-urlencode 'q=CREATE DATABASE mydb'
