resource "libvirt_network" "kube_net" {
  name   = "kube_net"
  mode   = "bridge"
  bridge = "br0"
  autostart = true
}