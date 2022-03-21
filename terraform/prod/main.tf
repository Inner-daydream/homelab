provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  allow_unverified_ssl = true
}


module "consul" {
  source     = "../modules/consul"
  vcpu       = 2
  ram        = 2048
  name       = "consul-prod"
  datastore  = "SDS2"
  network    = "VM Network"
  modular_ip = 248
}

module "nomad" {
  source     = "../modules/nomad"
  vcpu       = 2
  ram        = 4096
  name       = "nomad-prod"
  datastore  = "SDS2"
  network    = "VM Network"
  modular_ip = 245
}

module "glusterfs" {
  source     = "../modules/glusterfs"
  vcpu       = 2
  ram        = 2048
  name       = "glusterfs-prod"
  datastore  = "SDS2"
  network    = "VM Network"
  modular_ip = 230
}

module "vault" {
  source     = "../modules/vault"
  vcpu       = 2
  ram        = 2048
  name       = "vault-prod"
  datastore  = "SDS2"
  network    = "VM Network"
  modular_ip = 220
}

module "nginx" {
  source     = "../modules/nginx"
  vcpu       = 2
  ram        = 2048
  name       = "nginx-prod"
  datastore  = "SDS2"
  network    = "VM Network"
  modular_ip = 210
}

module "wordpress" {
  source     = "../modules/wordpress"
  vcpu       = 2
  ram        = 2048
  name       = "wordpress-prod"
  datastore  = "SDS2"
  network    = "VM Network"
  modular_ip = 200
}