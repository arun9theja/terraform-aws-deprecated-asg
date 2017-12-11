#cloud-config
bootcmd:
- TRAVELOKA_ENV=${traveloka-env} /etc/init.d/supervisor start
