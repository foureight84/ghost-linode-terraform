/* Linode Data */

# Load scripts as template and sort out variables

data "template_file" "docker_compose" {
  template = "${file("${path.module}/scripts/linode/docker-compose.yaml")}"

  vars = {
    "ghost_blog_url" = "${var.ghost_blog_url}"
    "letsencrypt_email" = "${var.letsencrypt_email}"
  }
}