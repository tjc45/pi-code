#!/bin/bash
# Script to do some first-time setup.  Needs to be run with sudo

# Redis
apt-get install -y redis-server
# Nginx
apt-get install -y nginx
# Python stuff
pip3 install virtualenv
