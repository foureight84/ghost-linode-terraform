provider "linode" {
  token = var.linode_api_token
}

provider "cloudflare" {
  api_key = var.cloudflare_api_key
  email = var.cloudflare_email
}