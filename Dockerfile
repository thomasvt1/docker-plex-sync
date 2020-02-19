FROM node:alpine

MAINTAINER Pat Sissons patricksissons@gmail.com

ENV PLEX_TOKEN="" \
    DRY_RUN="" \
    MATCH_TYPE="" \
    RATE_LIMIT="" \
    SECTION_MAPS="" \
    CRON_SCHEDULE="0 * * * *" \
    INITIAL_RUN="" \
    PACKAGE_DEPS="rsyslog" \
    NPM_PACKAGE_VERSION="0.6.1"

ADD root/ /

RUN  set -x \
  && apk add ${PACKAGE_DEPS} \
  && npm install -g --quiet plex-sync@${NPM_PACKAGE_VERSION} \
  && chmod 0755 /usr/local/bin/plex-sync-job \
  && chmod 0755 /usr/local/bin/plex-sync-entrypoint \
  && touch /var/log/cron.log

ENTRYPOINT ["/usr/local/bin/plex-sync-entrypoint"]
