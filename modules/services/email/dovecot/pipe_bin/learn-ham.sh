#!/bin/bash
set -o errexit
exec rspamc -c bayes_users -d "$2" -h /run/rspamd/worker-controller.sock learn_ham
