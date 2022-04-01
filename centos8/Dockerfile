FROM centos:8

ARG KENNA_API_KEY

COPY ./kenna-agent.rpm /tmp/kenna-agent.rpm
COPY ./kenna-agent.toml.template /tmp/kenna-agent.toml.template

RUN \
  # Check args
  : "${KENNA_API_KEY:?Build argument KENNA_API_KEY needs to be set and non-empty.}"

RUN \
  # Install kenna-agent
  && dnf localinstall -y --disablerepo=\* /tmp/kenna-agent.rpm \
  && systemctl enable kenna-agent \

  # Configure kenna-agent based on kenna-agent.toml.template
  && printf "$(</tmp/kenna-agent.toml.template)" \
       "PLEASE DO NOT EDIT, THIS FILE IS AUTO-GENERATED" \
       $KENNA_API_KEY \
       > /etc/kenna-agent/kenna-agent.toml \
  && kenna-agent check \
  # TODO make this fail

  # Clean up
  && rm /tmp/kenna-agent.rpm /tmp/kenna-agent.toml.template
