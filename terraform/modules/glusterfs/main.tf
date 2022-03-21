resource "vsphere_virtual_machine" "glusterfs" {
  count            = var.server
  name             = "${var.name}-${count.index}"
  datastore_id     = data.vsphere_datastore.ds.id
  resource_pool_id = data.vsphere_compute_cluster.compute_cluster.resource_pool_id
  num_cpus         = var.vcpu
  memory           = var.ram
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "${var.name}-${count.index}"
        domain    = var.domain
      }

      network_interface {
        ipv4_address = "${var.root_ip}.${var.modular_ip - count.index}"
        ipv4_netmask = var.netmask
      }

      ipv4_gateway = var.gateway
    }
  }
}