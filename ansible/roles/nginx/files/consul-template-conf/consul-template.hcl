vault {
  address      = "http://active.vault.service.consul:8200"
  token        = "TOKEN_REGEX"
  unwrap_token = false
  renew_token  = true
}
syslog {
  enabled  = true
  facility = "LOCAL5"
}
template {
  source      = "/etc/consul-template.d/templates/wildcard.crt.tpl"
  destination = "/etc/nginx/certs/wildcard.crt"
  perms       = 0700
  command     = "systemctl reload nginx"
}
template {
  source      = "/etc/consul-template.d/templates/wildcard.key.tpl"
  destination = "/etc/nginx/certs/wildcard.key"
  perms       = 0700
  command     = "systemctl reload nginx"
}
template {
  source      = "/etc/consul-template.d/templates/nomad_client.crt.tpl"
  destination = "/etc/nginx/certs/nomad_client.crt"
  perms       = 0700
  command     = "systemctl reload nginx"
}
template {
  source      = "/etc/consul-template.d/templates/nomad_client.key.tpl"
  destination = "/etc/nginx/certs/nomad_client.key"
  perms       = 0700
  command     = "systemctl reload nginx"
}
template {
  source      = "/etc/consul-template.d/templates/nomad_client.ca.tpl"
  destination = "/etc/nginx/certs/nomad_client.ca"
  perms       = 0700
  command     = "systemctl reload nginx"
}