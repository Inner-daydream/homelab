{{ with secret "pki_int/issue/lucasquitman-dot-fr" "common_name=*.lucasquitman.fr" "ttl=24h"}}
{{ .Data.private_key }}
{{ end }}
