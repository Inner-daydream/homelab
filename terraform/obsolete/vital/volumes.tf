resource "libvirt_volume" "vpn_volume" {
  name   = "vpn_volume.raw"
  source = "/srv/packer/output/vpn/vpn-base"
  pool   = libvirt_pool.vital_pool.name
}