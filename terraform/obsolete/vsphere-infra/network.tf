data "vsphere_network" "vm_net" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.Homelab.id
}