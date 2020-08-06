How to monitor a Zimbra Collaboration Environment using Telegraf, InfluxDB and Grafana
===================

Zimbra Collaboration Performance
* ZCS Version (Only 8.7 and above)
* Received Megabytes
* Total Emails/received
* Deferred
* Held
* Incoming
* Maildrop

Linux and machine performance:
* CPUs (defaults to all)
* Disks (per-disk IOPS)
* Network interfaces (packets, bandwidth, errors/drops)
* Mountpoints (space / inodes)



Get the stack (only once):

```
https://github.com/hotnan/docker-influxdb-grafana-telegraf-zimbra.git
cd docker-influxdb-grafana
docker pull grafana/grafana
docker pull influxdb
docker pull telegraf
```

Run your stack:

```
sudo mkdir -p ./grafana/data
docker-compose up -d
sudo chown -R 472:472 ./grafana/data

```

Show me the logs:

```
docker-compose logs
```

Stop it:

```
docker-compose stop
docker-compose rm
```

Update it:

```
git pull
docker pull grafana/grafana
docker pull influxdb
docker pull telegraf
```

### giving permission to telegraf process

```
sudo chgrp -R telegraf /opt/zimbra/data/postfix/spool/{active,hold,incoming,deferred,maildrop}
sudo chmod -R g+rXs /opt/zimbra/data/postfix/spool/{active,hold,incoming,deferred,maildrop}
sudo usermod -a -G postdrop telegraf
sudo chmod g+r /opt/zimbra/data/postfix/spool/maildrop
```
