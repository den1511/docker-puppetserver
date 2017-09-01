#!/bin/bash

. /etc/default/puppetserver

restartfile="/opt/puppetlabs/server/data/puppetserver/restartcounter"
cli_defaults=${INSTALL_DIR}/cli/cli-defaults.sh

LOG_APPENDER="-Dlogappender=STDOUT"
CLASSPATH="${INSTALL_DIR}/puppet-server-release.jar"

. $cli_defaults

COMMAND="${JAVA_BIN} ${JAVA_ARGS} ${LOG_APPENDER} \
         -Djava.security.egd=/dev/urandom \
         -cp "$CLASSPATH" \
         clojure.main -m puppetlabs.trapperkeeper.main \
         --config ${CONFIG} --bootstrap-config ${BOOTSTRAP_CONFIG} \
         --restart-file "${restartfile}" \
         ${@}"

echo Running command: $COMMAND
exec $COMMAND
