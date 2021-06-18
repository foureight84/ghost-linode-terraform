# Create Linode stackscript for boot time execution.
resource "linode_stackscript" "ghost_deploy" {
  script = "${data.template_file.stackscript.rendered}"

  description = <<EOF
  Installs Docker and deploys ghost blog stack containers
EOF

  rev_note = "initial ghost blog deploy script"

  images = [
    "linode/ubuntu20.04",
  ]

  is_public = false
  label     = "GhostDeploy"
}

# Create Linode instance using created stackscript above with data from templates passed to stackscript
resource "linode_instance" "ghost" {
  label = var.linode_label
  image = var.linode_image
  region = var.linode_region
  type = var.linode_type
  authorized_users = var.linode_authorized_users
  root_pass = var.linode_root_password

  group = var.linode_group
  tags = var.linode_tags
  private_ip = true

  stackscript_id = linode_stackscript.ghost_deploy.id

  stackscript_data = {
    "DOCKER_COMPOSE" = "${data.template_file.docker_compose.rendered}"
    "ENABLE_RCLONE" = var.enable_rclone
    "RCLONE_DOCKER_COMPOSE" = "${data.template_file.rclone_docker_compose.rendered}"
    "RCLONE_CONFIG" = "${data.template_file.rclone_config.rendered}"
    "BACKUP_SCRIPT" = "${data.template_file.backup_script.rendered}"
  }
}