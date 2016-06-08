#!/bin/sh
eyeos-service-ready-notify-cli &
eyeos-run-server --serf redis-server
