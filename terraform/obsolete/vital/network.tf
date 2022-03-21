resource "libvirt_network" "vital_net" {
  name   = "vital_net"
  mode   = "bridge"
  bridge = "br0"
  autostart = true
}