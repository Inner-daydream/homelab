job "gitea" {
  datacenters = ["Homelab"]
  type        = "service"

  group "gitea" {
    count = 1
    network {
    port "http" { to = 3000 }
    }
    restart {
      attempts = 10
      interval = "5m"
      delay    = "25s"
      mode     = "delay"
    }

    task "gitea" {
      driver = "docker"
      config {
        image = "gitea/gitea:latest"
        ports = ["http"]
        volumes = [
          "/mnt/glusterfs/gitea:/data"
        ]
      }

      service {
        name = "gitea"
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
