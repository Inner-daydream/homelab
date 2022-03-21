resource "libvirt_domain" "domain_vpn" {
  name      = "vpn"
  vcpu      = "1"
  memory    = "2048"
  autostart = true
  qemu_agent = true
  cloudinit  = libvirt_cloudinit_disk.vpn_init.id
  disk {
    volume_id = libvirt_volume.vpn_volume.id
  }
  network_interface {
    network_id = libvirt_network.vital_net.id
  }
}