#!/bin/bash
set -o errexit
cat | rspamc --header="settings-id=delivery" -d "$1" -h /run/rspamd/worker-controller.sock -m
