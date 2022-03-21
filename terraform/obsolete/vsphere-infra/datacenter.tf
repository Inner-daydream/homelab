provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  allow_unverified_ssl = true
}

data "vsphere_datacenter" "Homelab" {
  name = "Homelab"
}

data "vsphere_compute_cluster" "Main" {
  name          = "Main"
  datacenter_id = data.vsphere_datacenter.Homelab.id
}