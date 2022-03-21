resource "libvirt_volume" "master_golden" {
  name   = "master_golden.raw"
  source = "/srv/packer/output/master/master-base"
  pool   = libvirt_pool.backing_pool.name
}
resource "libvirt_volume" "master_volume" {
  count          = var.master_ammount
  name           = "master_${count.index}.raw"
  base_volume_id = libvirt_volume.master_golden.id
  pool           = libvirt_pool.k8_cluster_pool.name
}

resource "libvirt_volume" "minion_golden" {
  name   = "minion_golden.raw"
  source = "/srv/packer/output/minion/minion-base"
  pool   = libvirt_pool.backing_pool.name
}

resource "libvirt_volume" "minion_volume" {
  count          = var.minion_ammount
  name           = "minion_${count.index}.raw"
  base_volume_id = libvirt_volume.minion_golden.id
  pool           = libvirt_pool.k8_cluster_pool.name
}