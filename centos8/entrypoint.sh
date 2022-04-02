#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

function configure_kenna_agent {
  # Configure kenna-agent based on kenna-agent.toml.template
  printf "$(</etc/kenna-agent/kenna-agent.toml.template)" \
    "PLEASE DO NOT EDIT, THIS FILE IS AUTO-GENERATED" \
    $KENNA_API_KEY \
    > /etc/kenna-agent/kenna-agent.toml
}

if [[ "$*" = "kenna-agent" ]]
then
  # Check mandatory environment variables
  : "${KENNA_API_KEY:?ENV KENNA_API_KEY needs to be set and non-empty. See README.md.}"

  configure_kenna_agent

  # TODO make this able to fail launch
  /usr/bin/kenna-agent check

  exec /usr/bin/kenna-agent run -config /etc/kenna-agent/kenna-agent.toml
else
  KENNA_API_KEY=${KENNA_API_KEY:-}

  configure_kenna_agent

  exec "$@"
fi
