data "vsphere_datastore" "SDS1" {
  name          = "SDS1"
  datacenter_id = data.vsphere_datacenter.Homelab.id
}
data "vsphere_datastore" "SDS2" {
  name          = "SDS2"
  datacenter_id = data.vsphere_datacenter.Homelab.id
}