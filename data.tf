/* Linode Data */

# Load scripts as template and sort out variables

data "template_file" "stackscript" {
  template = "${file("${path.module}/scripts/linode/stackscript.sh")}"

  vars = {
    "rclone_dir" = "${var.rclone_dir}"
    "project_dir" = "${var.project_dir}"
  }
}

data "template_file" "docker_compose" {
  template = "${file("${path.module}/scripts/linode/docker-compose.yaml")}"

  vars = {
    "ghost_blog_url" = "${var.ghost_blog_url}"
    "letsencrypt_email" = "${var.letsencrypt_email}"
  }
}

data "template_file" "rclone_docker_compose" {
  template = "${file("${path.module}/scripts/rclone/docker-compose.yaml")}"

  vars = {
    "rclone_dir" = "${var.rclone_dir}"
  }
}

data "template_file" "rclone_config" {
  template = "${file("${path.module}/scripts/rclone/config/rclone.conf")}"
}

data "template_file" "backup_script" {
  template = "${file("${path.module}/scripts/rclone/backup.sh")}"

  vars = {
    "project_dir" = "${var.project_dir}"
    "rclone_dir" = "${var.rclone_dir}"
  }
}

/* Cloudflare */

# get managed domain being used for blog deployment. ex. foureight84.com
data "cloudflare_zones" "ghost_domain_zones" {
  filter {
    name   = var.cloudflare_domain
    status = "active"
  }
}