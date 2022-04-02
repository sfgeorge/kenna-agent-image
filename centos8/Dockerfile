FROM centos:8

COPY ./kenna-agent.rpm /tmp/

RUN true \
  # Install kenna-agent
  && dnf localinstall -y --disablerepo=\* /tmp/kenna-agent.rpm \

  # Clean up
  && dnf clean all \
  && rm /tmp/kenna-agent.rpm

COPY ./entrypoint.sh /
COPY ./kenna-agent.toml.template /etc/kenna-agent/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["kenna-agent"]
