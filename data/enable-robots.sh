#!/bin/bash

# Important files
CRON_FILE="$ROBOTS_ROOT/crontab"
REQUIREMENTS_FILE="$ROBOTS_ROOT/requirements.txt"
INIT_FILE="$ROBOTS_ROOT/_init.py"

# Keep pip up-to-date
pip3.5 install --upgrade pip

# Copy crontab
if [ -f $CRON_FILE ]; then
    cp $CRON_FILE /var/spool/cron/crontabs/root
fi;

# Install requirements
if [ -f $REQUIREMENTS_FILE ]; then
    pip3.5 install -r $REQUIREMENTS_FILE
fi;

# Run initialization
if [ -f $INIT_FILE ]; then
    python3.5 $INIT_FILE
fi;

# Start cron and tail logs
crond -b -L 0 && tail -f /var/log/robots.log
