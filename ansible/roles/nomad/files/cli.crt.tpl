{{ with secret "pki_int/issue/nomad-cluster" "ttl=24h" }}
{{ .Data.certificate }}
{{ end }}