#!/bin/sh
# <UDF name="DOCKER_COMPOSE" label="Docker compose file" default="" />

set +e +x
SCRIPT_PATH="/root/ghost"
mkdir -p "${SCRIPT_PATH}"

echo "${DOCKER_COMPOSE}" > "${SCRIPT_PATH}/docker-compose.yaml"


apt update
apt install -y wget

wget -O - https://get.docker.com | sh

apt install -y docker-compose

cd "${SCRIPT_PATH}"

docker-compose up -d