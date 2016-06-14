#!/bin/sh
eyeos-service-ready-notify-cli &
exec eyeos-run-server --serf redis-server
