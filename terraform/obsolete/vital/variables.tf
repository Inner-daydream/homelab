variable "vital_pool_path" {
  description = "path of the 'vital' pool"
  default     = "/srv/kvm/pools/vital_pool"
}
variable "cloudinit_pool" {
  description = "cloudinnit_pool path"
  default     = "/srv/kvm/cloudinnit_pool_vital"
}