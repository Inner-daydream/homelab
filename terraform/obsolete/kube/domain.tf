resource "libvirt_domain" "domain_master" {
  count     = var.master_ammount
  name      = "master-${count.index}"
  vcpu      = "4"
  memory    = "8124"
  autostart = true
  qemu_agent = true
  cloudinit  = libvirt_cloudinit_disk.master_init[count.index].id
  disk {
    volume_id = libvirt_volume.master_volume[count.index].id
  }
  network_interface {
    network_id = libvirt_network.kube_net.id
  }
}
resource "libvirt_domain" "domain_minion" {
  count      = var.minion_ammount
  cloudinit  = libvirt_cloudinit_disk.minion_init[count.index].id
  name       = "minion-${count.index}"
  vcpu       = "4"
  memory     = "8124"
  autostart  = true
  qemu_agent = true
  disk {
    volume_id = libvirt_volume.minion_volume[count.index].id
  }
  network_interface {
    network_id     = libvirt_network.kube_net.id
  }
}