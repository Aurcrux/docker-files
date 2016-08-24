#!/bin/bash

set -x
set -e

# Check if the backend server were exported as ENV variables
[ -z ${BACKEND_SERVERS} ] && echo -e "A list of backend server MUST be defined first.\nPlease set the ENV variable BACKEND_SERVERS with proper values (e.g mybacku.somewher:8080)." && exit 1

# Generate HAproxy config file
export GLOBAL_MAXCONN=${GLOBAL_MAXCONN:-2000}
export GLOBAL_USER=${GLOBAL_USER:-haproxy}
export GLOBAL_GROUP=${GLOBAL_GROUP:-haproxy}
export DEFAULTS_RETRIES=${DEFAULTS_RETRIES:-3}
export DEFAULTS_TIMEOUT_CONNECT=${DEFAULTS_TIMEOUT_CONNECT:-5000}
export DEFAULTS_TIMEOUT_CLIENT=${DEFAULTS_TIMEOUT_CLIENT:-10000}
export DEFAULTS_TIMEOUT_SERVER=${DEFAULTS_TIMEOUT_SERVER:-10000}
export FRONTEND_NAME=${FRONTEND_NAME:-myapp}
export FRONTEND_HOST=${FRONTEND_HOST:-0.0.0.0}
export FRONTEND_PORT=${LISTEN_PORT:-8080}
export BACKEND_NAME=${BACKEND_NAME:-mybackend}
export BACKEND_BALANCE=${BACKEND_BALANCE:-leastconn}
export BACKEND_MODE=${BACKEND_MODE:-http}


rm -f /tmp/haproxy.cfg
cat > /tmp/haproxy.cfg <<_EOF
global
  maxconn ${GLOBAL_MAXCONN}
  user ${GLOBAL_USER}
  group ${GLOBAL_GROUP}

defaults
  log     global
  option redispatch
  retries ${DEFAULTS_RETRIES}
  timeout connect  ${DEFAULTS_TIMEOUT_CONNECT}
  timeout client  ${DEFAULTS_TIMEOUT_CLIENT}
  timeout server  ${DEFAULTS_TIMEOUT_SERVER}

frontend ${FRONTEND_NAME}
  bind ${FRONTEND_HOST}:${FRONTEND_PORT}
  use_backend ${BACKEND_NAME}


backend ${BACKEND_NAME}
  balance ${BACKEND_BALANCE}
  mode ${BACKEND_MODE}
_EOF

COUNTER=0
for SRV in $(echo ${BACKEND_SERVERS} | tr ',' ' ')
do
  echo "  server backend-${COUNTER} ${SRV} check" >> /tmp/haproxy.cfg
  let "COUNTER+=1"
done

# Check if the generate config is valid 
haproxy -c -f /tmp/haproxy.cfg

# Run haproxy
exec haproxy -f /tmp/haproxy.cfg
