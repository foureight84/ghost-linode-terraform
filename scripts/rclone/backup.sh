#!/bin/bash

######################
# Delets files older than x days in specified backup directory
# Creates new backup
######################

# Number of days to keep
days=7

# What to backup
backup_files="${project_dir}/blog"

# Archive filename for yesterday
day="$(date -d "yesterday" +"%m-%d-%y")"
archive_file="backup-$${day}.tgz"

# Backup dir
dest="${rclone_dir}/mount/backup"

echo "$${dest}/latest.tgz"

# rename yesterday's backup
if [ -f "$${dest}/latest.tgz" ]; then
  mv "$${dest}/latest.tgz" "$${dest}/$${archive_file}"
fi

if ! [ -d $${dest} ]; then
  echo "$${dest} not found. Creating..."
  date
  echo
  mkdir -p $${dest}
fi

# Removing older backup
echo "Removing files older than $${days} in $${dest}"
find $${dest} -type f -mtime +$${days} -delete

# Print start status message
echo "Backing up $${backup_files} to $${dest}/latest.tgz"
date
echo

# Backup the files using tar.
tar czf "$${dest}/latest.tgz" -C "$(dirname $${backup_files})" "$(basename $${backup_files})"

# Print end status message.
echo
echo "Backup finished"
date
