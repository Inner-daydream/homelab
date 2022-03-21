source "vsphere-clone" "nomad-base" {
  template               = "base-ubuntu"
  CPUs                   = 2
  RAM                    = 2048
  cluster                = var.cluster
  datastore              = "SDS2"
  vm_name                = "nomad-base"
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
  network                = "VM Network"
  disk_controller_type   = ["lsilogic"]
  disk_size = 10000

  customize {
    linux_options {
      domain    = "lucasquitman.fr"
      host_name = "nomad-base"
    }
    network_interface {
      ipv4_address    = ""
      dns_server_list = ["192.168.1.1"]

    }
  }
}

build {
  sources = [
    "source.vsphere-clone.nomad-base",
  ]

  provisioner "ansible" {
    playbook_file           = "../../ansible/pre/pre-nomad.yaml"
    user                    = "sibelius"
    inventory_file_template = "{{build_name}} ansible_host={{ .Host }} ansible_user={{ .User }} ansible_port={{ .Port }}\n"
    inventory_directory = "../../ansible/inventory"
    extra_arguments = [
      "--extra-vars",
      "ansible_become_password='PACKER'"
    ]
  }
}