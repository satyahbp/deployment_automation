#!/bin/bash

# run it with bash
# first argument - service name
# second argument - git link
# in below if statement, add the systemd file names for the particular services to restart them

# giving service name to restart
if [ "$1" = "satyajeet_blog" ]; then
    service_to_restart="blog.service"
else
    echo "no service found"
fi

echo "Going for service: $1"; 

# creating a new backup
echo "removing old $1 backup";
rm -rf ./$1-bkp;
echo "creating a backup of current $1";
cp -r $1 $1-bkp;

# pulling from git
echo "removing the current $1";
rm -rf $1;
echo "cloning git";
git clone -b dev $2;

# adding environment
echo "adding .env file"
cp ./$1-bkp/.env ./$1/;

# changing user ownership
chown -R satyajeet:satyajeet ./$1

# restarting service
echo "restarting service $service_to_restart";
systemctl restart $service_to_restart;

