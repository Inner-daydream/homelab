variable "vsphere_server" {
  default = "vcenter.lucasquitman.fr"
}
variable "vsphere_user" {
  default = "administrator@vsphere.local"
}
variable "vsphere_password" {
  default = ""
}
variable "consul_count" {
  default = 3
}
variable "nomad_count" {
  default = 3
}
