{{ with secret "pki_int/issue/nomad-cluster" "common_name=nginx.global.nomad" "ttl=24h"}}
{{ .Data.issuing_ca }}
{{ end }}