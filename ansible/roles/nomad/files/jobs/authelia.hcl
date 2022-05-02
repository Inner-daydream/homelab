job "authelia" {
    datacenters = ["Homelab"]
    type        = "service"

    group "authelia" {
        count = 1
        network {
            port "http" {}
        }

        restart {
            attempts = 10
            interval = "5m"
            elay    = "25s"
            mode     = "delay"
        }
        task "authelia" {
            driver = "docker"
            config {
                image = "authelia/authelia"
                ports = ["http"]
                volumes = [
                    "/mnt/glusterfs/authelia:/config"
                ]
                args = [
                    "-e","AUTHELIA_PORT=${NOMAD_PORT_http}",
                    ]
            }
            env {
                AUTHELIA_THEME = "dark"
                AUTHELIA_DEFAULT_REDIRECTION_URL = "authelia.lucasquitman.fr"
                AUTHELIA_TOTP_ISSUER = "authelia.com"
                AUTHELIA_LOG_LEVEL = "debug"
                AUTHELIA_JWT_SECRET_FILE = "/config/jwt"
                AUTHELIA_AUTHENTICATION_BACKEND_FILE = "/config/users_database.yml"
                AUTHELIA_SESSION_SECRET_FILE = "/config/session"
                AUTHELIA_STORAGE_ENCRYPTION_KEY_FILE = "/config/encryption"
            }
            service {
                name = "authelia"
                port = "http"
                tags = [
                    "proxy.nginx.lucasquitman.fr"
                ]
                check {
                    type     = "tcp"
                    interval = "10s"
                    timeout  = "2s"
                }
            }
        }
    }
}
