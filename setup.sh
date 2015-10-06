#!/bin/bash
# Script to do some first-time setup.  Needs to be run with sudo

# Assumes preconfigured with:
# raspi-config,watchdog,chkconfig,git,nano,sudo,python3-dev,python3-pip,i2c-tools
# otherwise these need installing with apt-get -y ...

# First things to do
# raspi-config
# passwd
# dpkg-reconfigure locales
# dpkg-reconfigure tzdata
# nano /etc/ssh/sshd_config
# ... and comment out AcceptEnv LANG LC_*

# To update kernel:
# rpi-update
# then http://raspberrypi.stackexchange.com/questions/36212/version-for-uname-r-remains-despite-successful-rpi-update

# Copy this file
# scp setup.sh root@<IP_ADDRESS>:~/setup.sh
# chmod u+x ~/setup.sh

# Update/upgrade
apt-get -y update
apt-get -y upgrade

# Setup hardware watchdog
modprobe bcm2708_wdog

echo "bcm2708_wdog" >> /etc/modules
update-rc.d watchdog defaults
echo "watchdog-device = /dev/watchdog" >> /etc/watchdog.conf
echo "max-load-1 = 24" >> /etc/watchdog.conf
echo "[Install]" >> /lib/systemd/system/watchdog.service
echo "WantedBy=multi-user.target" >> /lib/systemd/system/watchdog.service

systemctl enable watchdog
sudo /etc/init.d/watchdog start


# Basic software
echo "alias python=python3" >> ~/.bashrc

# SD card optimisations
#echo "tmpfs    /tmp    tmpfs    defaults,noatime,nosuid,size=50m    0 0" >> /etc/fstab
#echo "tmpfs    /var/tmp    tmpfs    defaults,noatime,nosuid,size=30m    0 0" >> /etc/fstab
#echo "tmpfs    /var/log    tmpfs    defaults,noatime,nosuid,mode=0755,size=50m    0 0" >> /etc/fstab
