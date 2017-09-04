FROM ubuntu:xenial

EXPOSE 8140

ENV RELEASE xenial

ENV \
  LANGUAGE=en_US.UTF-8 \
  LC_ALL=en_US.UTF-8 \
  LANG=en_US.UTF-8 \

  PUPPET_AGENT_VERSION=5.1.0-1${RELEASE} \
  PUPPETSERVER_VERSION=5.0.0-1puppetlabs1 \
  PUPPETDB_VERSION=5.0.1-1puppetlabs1 \

  RUBY_GPG_VERSION=0.3.2 \
  HIERA_EYAML_GPG_VERSION=0.5.0 \

  PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

RUN apt-get update \
  && apt-get install -y curl locales-all \
  && curl -O http://apt.puppetlabs.com/puppet5-release-${RELEASE}.deb \
  && dpkg -i puppet5-release-${RELEASE}.deb \
  && rm puppet5-release-${RELEASE}.deb \
  && apt-get update \
  && apt-get install -y --force-yes git \
    puppet-agent=$PUPPET_AGENT_VERSION \
    puppetserver=$PUPPETSERVER_VERSION \
    puppetdb-termini=$PUPPETDB_VERSION \
  && rm -rf /var/lib/apt/lists/*

# Allow JAVA_ARGS tuning
RUN sed -i -e 's@^JAVA_ARGS=\(.*\)$@JAVA_ARGS=\$\{JAVA_ARGS:-\1\}@' /etc/default/puppetserver

# Support Arbitrary User IDs
RUN \
  chgrp -R 0 /etc/puppetlabs/puppetserver && \
  chmod -R g=u /etc/puppetlabs/puppetserver && \
  chgrp -R 0 /opt/puppetlabs && \
  chmod -R g=u /opt/puppetlabs && \
  chgrp -R 0 /var/log/puppetlabs && \
  chmod -R g=u /var/log/puppetlabs

USER 999

RUN puppetserver gem install ruby_gpg --version $RUBY_GPG_VERSION --no-ri --no-rdoc \
  && puppetserver gem install hiera-eyaml-gpg --version $HIERA_EYAML_GPG_VERSION --no-ri --no-rdoc

VOLUME ["/etc/puppetlabs/code/environments"]

COPY /docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
