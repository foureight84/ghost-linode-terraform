### `stackscript.sh`

Linode's first boot executiong script. https://www.linode.com/docs/guides/platform/stackscripts/

We use this to automate env preparation.
- Pass over bash and docker-compose scripts
- Install docker and components
- Run rclone if enabled
- Restore blog backup if it exists in mounted cloud drive
- Run ghost stack

### `docker-compose.yaml`

- Jwilder's nginx-proxy to direct incoming requests to the correct application
- Jrcs's letsencrypt-nginx-proxy-companion for automatic ssl generation
- Ghost blob container. Uses default sqlite database. We're not expecting a massive blog and this will do just fine. Also makes it easier to work with remote backup strategy using rclone