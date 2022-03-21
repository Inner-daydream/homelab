resource "libvirt_cloudinit_disk" "minion_init" {
  count          = var.minion_ammount
  name           = "minion_init_${count.index}.iso"
  pool           = libvirt_pool.cloudinit_pool.name
  user_data =<<-EOT
    #cloud-config
    hostname: minion-${count.index}
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
                - 192.168.1.${20+count.index+var.master_ammount}/24
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
      - sudo hostname minion-${count.index}
      - sudo netplan apply
    EOT
}
resource "libvirt_cloudinit_disk" "master_init" {
  count = var.master_ammount
  name = "master_init_${count.index}"
  pool = libvirt_pool.cloudinit_pool.name
  user_data =<<-EOT
    #cloud-config
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
                - 192.168.1.${20+count.index}/24
                gateway4: 192.168.1.254
                nameservers:
                  addresses:
                  - 192.168.1.254
                  - 1.1.1.1
                  - 8.8.8.8
                  - 8.8.4.4
                  search: []
            version: 2

    runcmd:
      - sudo rm -rf /etc/netplan/50-cloud-init.yaml
      - sudo netplan apply
      - sudo hostname master
    EOT  
}