resource "libvirt_cloudinit_disk" "vpn_init" {
  name           = "vpn_init.iso"
  pool           = libvirt_pool.cloudinit_pool_vital.name
  user_data =<<-EOT
    #cloud-config
    hostname: vpn
    users:
      - root
    write_files:
      - path:  /etc/netplan/00-installer-config.yaml
        permissions: '0644'
        content: |
          network:
            ethernets:
              ens3:
                addresses:
                - 192.168.1.2/24
                gateway4: 192.168.1.254
                nameservers:
                  addresses:
                  - 192.168.1.254
                  - 1.1.1.1
                  - 8.8.8.8
                  search: []
            version: 2

    runcmd:
      - sudo rm -rf /etc/netplan/50-cloud-init.yaml
      - sudo hostname vpn
      - sudo netplan apply
    EOT
}