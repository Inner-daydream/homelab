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
resource "null_resource" "post-consul" {
  depends_on = [module.consul]
  provisioner "local-exec" {
    command = "ansible-playbook ../../ansible/post/post-consul.yaml"
  }
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
resource "null_resource" "post-nomad" {
  depends_on = [module.nomad]
  provisioner "local-exec" {
    command = "ansible-playbook ../../ansible/post/post-nomad.yaml"
  }
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
resource "null_resource" "post-glusterfs" {
  depends_on = [module.glusterfs]
  provisioner "local-exec" {
    command = "ansible-playbook ../../ansible/post/post-glusterfs-server.yaml"
  }
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
resource "null_resource" "post-vault" {
  depends_on = [module.vault]
  provisioner "local-exec" {
    command = "ansible-playbook ../../ansible/post/post-vault.yaml"
  }
}
module "nginx" {
  source     = "../modules/nginx"
  vcpu       = 2
  ram        = 2048
  name       = "nginx-prod"
  datastore  = "SDS2"
  network    = "VM Network"
  modular_ip = 210
  server = 1
}