{{ with secret "pki_int/issue/nomad-cluster" "common_name=nginx.global.nomad" "ttl=24h" "alt_names=localhost" "ip_sans=127.0.0.1"}}
{{ .Data.certificate }}
{{ end }}