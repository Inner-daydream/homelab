variable "server" {
  default = 3
}
variable "vcpu" {
    default = 2
}
variable "ram" {
    default = 2048
}
variable "name" {
    description = "base name (before increment) of the glusterfs instance"
    default = ""
}
variable "datastore" {
    default = ""
}
variable "network" {
    default = "Vm Network"
}
variable "modular_ip" {
  default = 0
}
variable "root_ip" {
  default = "192.168.1"
}
variable "datacenter" {
  default = "homelab"
}
variable "compute_cluster" {
  default = "main"
}
variable "domain" {
  default = "lucasquitman.fr"
}
variable "netmask" {
  default = 24
}
variable "gateway" {
  default = "192.168.1.254"
}