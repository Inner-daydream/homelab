source "vsphere-iso" "base-ubuntu" {
  CPUs      = 2
  RAM       = 2048
  boot_wait = "4s"
  boot_command = [
    "<enter><enter><f6><esc><wait>",
    "autoinstall ds=nocloud-net",
    "<enter><wait600>"
  ]

  cd_files               = ["../subiquity/http/meta-data", "../subiquity/http/user-data"]
  cd_label               = "cidata"
  guest_os_type          = "ubuntu64Guest"
  cluster                = var.cluster
  datastore              = "SDS1"
  iso_paths              = ["[SDS1] 00-ISO/ubuntu-20.04.4-live-server-amd64.iso"]
  vm_name                = "base-ubuntu"
  shutdown_command       = "echo 'PACKER' | sudo -S shutdown -P now"
  username               = var.Vusername
  password               = var.Vpassword
  insecure_connection    = true
  vcenter_server         = "vcenter.lucasquitman.fr"
  ssh_username           = "sibelius"
  ssh_handshake_attempts = 300
  ssh_timeout            = "40m"
  ssh_private_key_file   = "~/.ssh/github"
  remove_cdrom           = true
  convert_to_template    = true
  folder                 = "golden-images"


  network_adapters {
    network_card = "vmxnet3"
    network      = "VM Network"
  }

  storage {
    disk_size             = 4000
    disk_thin_provisioned = true
  }
}

build {
  sources = ["source.vsphere-iso.base-ubuntu"]
  provisioner "ansible" {
    playbook_file = "../../ansible/pre/base-image.yaml"
    user          = "sibelius"
    extra_arguments = [
      "--extra-vars",
      "ansible_become_password='PACKER'"
    ]
  }
}