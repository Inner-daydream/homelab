source "vsphere-clone" "consul0" {

  template = "base-ubuntu"
  CPUs      = 2
  RAM       = 2048
  cluster                = var.cluster
  datastore              = "SDS1"
  vm_name                = "consul0"
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
  folder                 = "consul"
  network = "VM Network"
  disk_controller_type = ["lsilogic"]


  
  customize {
    linux_options {
      domain = "lucasquitman.fr"
      host_name = "consul0"
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

source "vsphere-clone" "consul1" {

  template = "base-ubuntu"
  CPUs      = 2
  RAM       = 2048
  cluster                = var.cluster
  datastore              = "SDS1"
  vm_name                = "consul1"
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
  folder                 = "consul"
  network = "VM Network"
  disk_controller_type = ["lsilogic"]


  
  customize {
    linux_options {
      domain = "lucasquitman.fr"
      host_name = "consul1"
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

source "vsphere-clone" "consul2" {

  template = "base-ubuntu"
  CPUs      = 2
  RAM       = 2048
  cluster                = var.cluster
  datastore              = "SDS1"
  vm_name                = "consul2"
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
  folder                 = "consul"
  network = "VM Network"
  disk_controller_type = ["lsilogic"]


  
  customize {
    linux_options {
      domain = "lucasquitman.fr"
      host_name = "consul2"
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
  sources = [
      "source.vsphere-clone.consul0",
      "source.vsphere-clone.consul1",
      "source.vsphere-clone.consul2"
    ]

  provisioner "shell-local" {
    inline = ["rm -rf /home/sibelius/.secrets/consul"]
  }
  provisioner "ansible" {
    playbook_file = "../../../ansible/consul.yaml"
    user          = "sibelius"
    inventory_file_template = "{{build_name}} ansible_host={{ .Host }} ansible_user={{ .User }} ansible_port={{ .Port }}\n"
    extra_arguments = [
      "--extra-vars",
      "ansible_become_password='PACKER'"
    ]
  }

  error-cleanup-provisioner "shell-local" {
    inline = ["rm -rf /tmp/ansible"]
  }

  post-processor "shell-local" {
    inline = ["rm -rf /tmp/ansible"]
  }
}