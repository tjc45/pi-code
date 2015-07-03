#!/bin/bash
# Script to do some first-time setup.  Needs to be run with sudo

# First things to do
# sudo apt-get install rasp-config
# raspi-config
# passwd

# Copy this file
# scp setup.sh root@<IP_ADDRESS>:~/setup.sh
# chmod u+x ~/setup.sh

# Update/upgrade
apt-get -y update
apt-get -y upgrade
rpi-update

# Setup hardware watchdog
modprobe bcm2708_wdog
apt-get -y install watchdog
apt-get -y install chkconfig

echo "bcm2708_wdog" >> /etc/modules
update-rc.d watchdog defaults
echo "watchdog-device = /dev/watchdog" >> /etc/watchdog.conf
echo "max-load-1 = 24" >> /etc/watchdog.conf
chkconfig watchdog on
sudo /etc/init.d/watchdog start


# Basic software

# Sudo
apt-get -y install sudo
# Nano
apt-get -y install nano
# Git
apt-get -y install git
# Python
apt-get -y install python3-dev
apt-get -y install python3-pip
echo "alias python=python3" >> ~/.bashrc
# I2C tools
apt-get -y install i2c-tools


# SD card optimisations
echo "tmpfs   /var/log    tmpfs    defaults,noatime,nosuid,mode=0755,size=100m    0 0" >> /etc/fstab
echo "tmpfs    /tmp    tmpfs    defaults,noatime,nosuid,size=100m    0 0" >> /etc/fstab
echo "tmpfs    /var/tmp    tmpfs    defaults,noatime,nosuid,size=30m    0 0" >> /etc/fstab
echo "tmpfs    /var/log    tmpfs    defaults,noatime,nosuid,mode=0755,size=100m    0 0" >> /etc/fstab
echo "tmpfs    /var/run    tmpfs    defaults,noatime,nosuid,mode=0755,size=2m    0 0" >> /etc/fstab
echo "tmpfs    /var/spool/mqueue    tmpfs" >> /etc/fstab
echo "defaults,noatime,nosuid,mode=0700,gid=12,size=30m    0 0" >> /etc/fstab