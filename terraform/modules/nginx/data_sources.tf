data "vsphere_datacenter" "dc" {
  name = var.datacenter
}
data "vsphere_compute_cluster" "compute_cluster" {
  name          = var.compute_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "ds" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "nginx-base"
  datacenter_id = data.vsphere_datacenter.dc.id
}