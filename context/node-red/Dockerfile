FROM nodered/node-red:latest-18

RUN npm install uuid
RUN npm install redis
RUN npm install systeminformation
RUN npm install node-red-contrib-os
RUN npm install node-red-contrib-fs-ops
RUN npm install node-red-contrib-cpu
RUN npm install node-red-contrib-uuid
RUN npm install node-red-contrib-rate
RUN npm install node-red-contrib-counter
RUN npm install node-red-contrib-redis
RUN npm install node-red-node-redis
RUN npm install node-red-node-daemon
RUN npm install node-red-node-smooth
RUN npm install node-red-dashboard
RUN npm install node-red-node-ui-iframe
RUN npm install node-red-node-ui-table
RUN npm install node-red-contrib-ui-contextmenu
RUN npm install node-red-contrib-ui-upload
RUN npm install "@prescient-devices/node-red-contrib-downloadfile"

# uncomment the following 2 lines for production
#COPY ./node-red/mgmt-data /data
#VOLUME /data
COPY ./node-red/daemon.js /usr/src/node-red/node_modules/node-red-node-daemon/daemon.js

COPY ./node-red/etc/vcache-mgr /etc/vcache-mgr
COPY ./perllib /usr/local/perllib
COPY ./scripts/ /usr/local/bin

USER root
RUN apk add bash
RUN apk add perl
RUN apk add gettext
RUN apk add zip

RUN apk add salt-master
COPY ./node-red/salt /srv/salt
COPY ./node-red/etc/salt/master /etc/salt/master
COPY ./node-red/etc/salt/reactor.conf /etc/salt/master.d/reactor.conf
VOLUME /etc/salt

RUN apk add py3-pip py3-numpy py3-pandas py3-scikit-learn py3-pycryptodome
#RUN apk add py3-pip py3-numpy py3-pandas py3-scikit-learn
RUN pip install contextvars
RUN pip install redis
RUN apk add redis

RUN apk add logrotate
COPY ./node-red/etc/logrotate.conf /etc

RUN echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf

COPY ./node-red/custom-entrypoint.sh /usr/src/node-red/custom-entrypoint.sh
# ENTRYPOINT ["/usr/src/node-red/custom-entrypoint.sh"]

