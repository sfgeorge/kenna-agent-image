FROM centos:8

ARG KENNA_API_KEY

COPY ./entrypoint.sh /
COPY ./kenna-agent.rpm /tmp/
COPY ./kenna-agent.toml.template /etc/kenna-agent/

RUN true \
  # Install kenna-agent
  && dnf localinstall -y --disablerepo=\* /tmp/kenna-agent.rpm \

  # Check mandatory build argument
  && : "${KENNA_API_KEY:?Build argument KENNA_API_KEY needs to be set and non-empty. See README.md.}" \

  # Configure kenna-agent based on kenna-agent.toml.template
  && printf "$(</etc/kenna-agent/kenna-agent.toml.template)" \
       "PLEASE DO NOT EDIT, THIS FILE IS AUTO-GENERATED" \
       $KENNA_API_KEY \
       > /etc/kenna-agent/kenna-agent.toml \

  # TODO make this able to fail the build
  && kenna-agent check \

  # Clean up
  && dnf clean all \
  && rm /tmp/kenna-agent.rpm \
  && (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
  rm -f \
    /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/basic.target.wants/* \
    /lib/systemd/system/anaconda.target.wants/* \

  # Enable kenna-agent
  && systemctl enable kenna-agent

CMD ["/usr/sbin/init"]
