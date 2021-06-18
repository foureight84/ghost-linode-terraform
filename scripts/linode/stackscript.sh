#!/bin/sh
# <UDF name="DOCKER_COMPOSE" label="Docker compose file" default="" />
# <UDF name="ENABLE_RCLONE" label="(Bool) Flag to turn on RClone Support" default="false" />
# <UDF name="RCLONE_DOCKER_COMPOSE" label="RClone docker compose file" default="" />
# <UDF name="RCLONE_CONFIG" label="RClone configuration file" default="" />
# <UDF name="BACKUP_SCRIPT" label="Backup script" default="" />

set +e +x
RCLONE_PATH="${rclone_dir}"

STACK_PATH="${project_dir}"
mkdir -p "$${STACK_PATH}"

echo "$${DOCKER_COMPOSE}" > "$${STACK_PATH}/docker-compose.yaml"


apt update
apt install -y wget

wget -O - https://get.docker.com | sh

apt install -y docker-compose


# Launch Rclone doceker container with premade config and mount remote drive
if [ $${ENABLE_RCLONE} ]; then
  mkdir -p "$${RCLONE_PATH}/config"
  mkdir -p "$${RCLONE_PATH}/mount"

  echo "$${RCLONE_CONFIG}" > "$${RCLONE_PATH}/config/rclone.conf"
  echo "$${RCLONE_DOCKER_COMPOSE}" > "$${RCLONE_PATH}/docker-compose.yaml"
  echo "$${BACKUP_SCRIPT}" > "$${RCLONE_PATH}/backup.sh"

  chmod +x "$${RCLONE_PATH}/backup.sh"

  # Add backup crontab
  # Runs at 11pm machine time (this could be UTC if timezone not set)
  (crontab -l ; echo "* 23 * * * bash $${RCLONE_PATH}/backup.sh >/dev/null 2>&1") | crontab -


  cd "$${RCLONE_PATH}"
  docker-compose pull
  docker-compose up -d
fi

# Execute Ghost Stack
# Technically don't need to use docker-compose pull but I am buying time in case rclone hasn't fully synched with remote service
cd "$${STACK_PATH}"
docker-compose pull

#restore backup
if [ $${ENABLE_RCLONE} ] && [ -f "$${RCLONE_PATH}/mount/backup/latest.tgz" ]; then
  tar -xvzf "$${RCLONE_PATH}/mount/backup/latest.tgz" -C $${STACK_PATH}
fi

docker-compose up -d