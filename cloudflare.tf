resource "cloudflare_record" "ghost_blog_record" {
  zone_id = lookup(data.cloudflare_zones.ghost_domain_zones.zones[0], "id")
  type    = "A"
  name    = var.ghost_blog_url
  value   = linode_instance.ghost.ip_address
  ttl     = "1"
	proxied = true
 }

resource "cloudflare_zone_settings_override" "ghost_zone_settings" {
    zone_id = lookup(data.cloudflare_zones.ghost_domain_zones.zones[0], "id")
    settings {
        always_use_https = "off"
        opportunistic_encryption = "off"
        automatic_https_rewrites = "on"
        always_online = "on"
        http3 = "on"
        min_tls_version = "1.2"
        brotli = "on"
        ssl = "strict"
        minify {
            css = "on"
            js = "on"
            html = "on"
        }
    }
}

resource "cloudflare_page_rule" "letsencrypt_verify" {
  zone_id = lookup(data.cloudflare_zones.ghost_domain_zones.zones[0], "id")
  target = "*${var.cloudflare_domain}/.well-known/*"
  actions {
    disable_security = true
    cache_level = "bypass"
    automatic_https_rewrites = "off"
  }

}

resource "cloudflare_authenticated_origin_pulls" "auth_origin_pull" {
  zone_id     = lookup(data.cloudflare_zones.ghost_domain_zones.zones[0], "id")
  enabled     = true
}