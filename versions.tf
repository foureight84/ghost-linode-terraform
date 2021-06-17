terraform {
  required_providers {
      linode = {
        source = "linode/linode"
        version = "1.18.0"
      }

      cloudflare = {
        source = "cloudflare/cloudflare"
        version = "2.21.0"
      }
  }
}