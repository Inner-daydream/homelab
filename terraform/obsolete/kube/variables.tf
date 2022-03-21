variable "master_ammount" {
  description = "ammount of k8 master nodes"
  default     = 1
}

variable "minion_ammount" {
  description = "ammount of k8 minion nodes"
  default     = 3
}
variable "ubuntu_20_04" {
  description = "ubuntu 20.04 live server iso"
  default     = "/srv/kvm/iso/ubuntu-20.04.2-live-server-amd64.iso"
}
variable "ubuntu_20_04_DTP" {
  description = "ubuntu 20.04 desktop iso"
  default     = "/srv/kvm/iso/ubuntu-20.04.2.0-desktop-amd64.iso"
}

variable "k8_cluster_pool" {
  description = "kubernetes cluster pool path"
  default     = "/srv/kvm/k8_cluster_pool"
}
variable "backing_pool" {
  description = "backing pool path"
  default     = "/srv/kvm/backing-pool"
}

variable "cloudinit_pool" {
  description = "cloudinnit_pool path"
  default     = "/srv/kvm/cloudinnit_pool_k8"
}