#!/bin/bash
set -ex

LOG_DIR=/home/isucon/log
mkdir -p ${LOG_DIR}

# alp
if [ -f ${LOG_DIR}/alp.log ]; then
    sudo mv ${LOG_DIR}/alp.log ${LOG_DIR}/alp.log.$(date "+%Y%m%d_%H%M%S")
fi
sudo /usr/local/bin/alp -f /var/log/nginx/access.log --sum -r --aggregates='/api/courses/[A-Z0-9]+/classes$,/api/courses/[A-Z0-9]+/classes/[A-Z0-9]+/assignments$,/api/announcements/[A-Z0-9]+$,/api/courses/[A-Z0-9]+/classes/[A-Z0-9]+/assignments/export$,/api/courses/[A-Z0-9]+/classes/[A-Z0-9]+/assignments/scores$,/api/courses/[A-Z0-9]+$,/api/courses/[A-Z0-9]+/status$' > ${LOG_DIR}/alp.log

# sudo /usr/local/bin/alp -f /var/log/nginx/access.log --sum -r --aggregates='/api/courses/[A-Z0-9]+/classes$,/api/courses/[A-Z0-9]+/classes/[A-Z0-9]+/assignments$,/api/announcements/[A-Z0-9]+,/api/courses/[A-Z0-9]+/classes/[A-Z0-9]+/assignments/export,/api/courses/[A-Z0-9]+/classes/[A-Z0-9]+/assignments/scores,/api/courses/[A-Z0-9]+/status,/api/courses/[A-Z0-9]+' > ${LOG_DIR}/alp.log


# slow query
if [ -f ${LOG_DIR}/mysql-slow-query.log ]; then
    sudo mv ${LOG_DIR}/mysql-slow-query.log ${LOG_DIR}/mysql-slow-query.log.$(date "+%Y%m%d_%H%M%S")
fi
sudo /usr/local/bin/pt-query-digest /var/log/mysql/mysql-slow.log > ${LOG_DIR}/mysql-slow-query.log
