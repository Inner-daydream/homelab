resource "libvirt_pool" "vital_pool" {
  name = "vital_pool"
  type = "dir"
  path = var.vital_pool_path
}

resource "libvirt_pool" "cloudinit_pool_vital" {
  name = "cloudinit_pool_vital"
  type = "dir"
  path = var.cloudinit_pool
}