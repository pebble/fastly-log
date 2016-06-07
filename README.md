Description
===========

Base copied from github.com/pebble/docker-td-agent

Usage
=====

    docker build -t pebble/fastly-log .
    docker run -p 514:514 -e TD_API_KEY=APIKEYGOESHERE pebble/fastly-log