resource "libvirt_pool" "k8_cluster_pool" {
  name = "k8_cluster_pool"
  type = "dir"
  path = var.k8_cluster_pool
}
resource "libvirt_pool" "backing_pool" {
  name = "backing_pool"
  type = "dir"
  path = var.backing_pool
}

resource "libvirt_pool" "cloudinit_pool" {
  name = "cloudinit_pool_k8"
  type = "dir"
  path = var.cloudinit_pool
}