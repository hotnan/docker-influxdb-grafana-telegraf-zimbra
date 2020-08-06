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


# copy file to zimbra server and run command

```
/opt/zimbra/common/bin/checkzimbraversion.sh
chmod +x /opt/zimbra/common/bin/checkzimbraversion.sh
```


# Install Telegarf on Zimbra Server

```
$ sudo apt-get update && sudo apt-get install telegraf
```

# Configuring Telegraf

Once installed, you will need to make some changes to the default configuration file that Telegraf ships with. To do this we can edit the telegraf.conf file.

```
$ sudo nano /etc/telegraf/telegraf.conf
```

```
[[outputs.influxdb]]
  urls = ["http://10.0.0.56:8086"]
  database = "mydb"
```


# Collector Config

copy telegraf to  /etc/telegraf.d/zimbra_telegraf.conf with inputs for Zimbra Processes, Zimbra Script

# run this command with zimbra user 

```
zmlocalconfig -s zimbra_ldap_password ldap_master_url
```

# Change data on section

```
[[inputs.openldap]]
   host = "YOURZIMBRASERVERHOSTNAME"
   port = 389
   insecure_skip_verify = true
   bind_dn = "uid=zimbra,cn=admins,cn=zimbra"
   bind_password = "YOURZIMBRALDAPPASSWORD"
   reverse_metric_names = true
```

# Upload Zimbra Dashbaord to Grafana
