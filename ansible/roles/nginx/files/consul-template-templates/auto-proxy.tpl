{{- range services -}}
{{- if .Tags | contains "proxy.nginx.lucasquitman.fr" -}}
upstream nomad-{{ .Name }} {
{{- range service .Name }}
{{- if gt .Port 0 }}
    server {{ .Address }}:{{ .Port }};
{{- end }}
{{- end }}
    server 127.0.0.1:9 down;
}
server {
    listen 80;
    listen 443 ssl;
    server_name {{ .Name }}.lucasquitman.fr www.{{ .Name }}.lucasquitman.fr;
    ssl_certificate /etc/nginx/certs/wildcard.crt;
    ssl_certificate_key /etc/nginx/certs/wildcard.key;
    location / {
        proxy_pass http://nomad-{{ .Name }};
    }
}
{{ end }} {{ end }}