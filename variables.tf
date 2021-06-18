# Linode variables
variable "linode_api_token" {
  type = string
  description = "This is your Linode APIv4 Token"
}

variable "linode_label" {
  type = string
  description = "Label for created node"
}

variable "linode_image" {
  type = string
  description = "An Image ID to deploy the Disk from. See https://api.linode.com/v4/images"
}

variable "linode_region" {
  type = string
  description = "This is the location where the Linode is deployed. See https://api.linode.com/v4/regions"
}

variable "linode_type" {
  type = string
  description = "The Linode type defines the pricing, CPU, disk, and RAM specs of the instance. See https://api.linode.com/v4/linode/types"
}

variable "linode_authorized_users" {
  type = list(string)
  description = "A list of Linode usernames. If the usernames have associated SSH keys, the keys will be appended to the root user's ~/.ssh/authorized_keys file automatically. This MySQL ROOT user password can not be imported. Changing authorized_users forces the creation of a new Linode Instance.\n\nInput answer in list notation: [\"string\",\"string1\"]"
}

variable "linode_root_password" {
  type = string
  description = "Container root user password."
}

variable "linode_group" {
  type = string
  description = "The display group of the Linode instance."
}

variable "linode_tags" {
  type = list(string)
  description = "A list of tags applied to this object. Tags are for organizational purposes only.\n\nInput answer in list notation: [\"string\",\"string1\"]"
}

# Cloudflare variables
variable "cloudflare_domain" {
  type = string
  description = "Domain name. ex. foureight84.com"
}

variable "cloudflare_email" {
  type = string
  description = "Cloudflare account email address"
}

variable "cloudflare_api_key" {
  type = string
  description = "Cloudflare API access key. Not to be mistaken with API token"
}

# others

variable "letsencrypt_email" {
  type = string
  description = "Email address to use for Let's Encrypt certificate"
}

variable "ghost_blog_url" {
  type = string
  description = "Blog URL. ex. blog.foureight84.com"
}

variable "enable_rclone" {
  type = bool 
  description = "Enable rclone backup"
}

variable "project_dir" {
  type = string
  description = "Project directory"
  default = "/root/ghost"
}

variable "rclone_dir" {
  type =  string
  description = "Rclone directory"
  default = "/root/rclone"
}