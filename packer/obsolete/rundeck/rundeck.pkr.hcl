source "vsphere-clone" "rundeck" {

  template = "base-ubuntu"
  CPUs      = 2
  RAM       = 2048
  cluster                = var.cluster
  datastore              = "SDS1"
  vm_name                = "rundeck_base"
  shutdown_command       = "echo '${var.shutdown_password}' | sudo -S shutdown -P now"
  username               = var.Vusername
  password               = var.Vpassword
  insecure_connection    = true
  vcenter_server         = "vcenter.lucasquitman.fr"
  ssh_username           = "sibelius"
  ssh_handshake_attempts = 120
  ssh_timeout            = "30m"
  ssh_private_key_file   = "~/.ssh/github"
  convert_to_template    = true
  folder                 = "golden-images"
  network = "VM Network"
  disk_controller_type = ["lsilogic"]


  
  customize {
    linux_options {
      domain = "lucasquitman.fr"
      host_name = "rundeck"
    }
    network_interface {
      ipv4_address = ""
      dns_server_list = ["192.168.1.1"]

    }
  }


  storage {
    disk_size = 15000
    disk_controller_index = 0
  }
}

build {
  sources = ["source.vsphere-clone.rundeck"]
  provisioner "ansible" {
    playbook_file = "../../../ansible/rundeck.yaml"
    user          = "sibelius"
    extra_arguments = [
      "--extra-vars",
      "ansible_become_password='PACKER'"
    ]
  }
}