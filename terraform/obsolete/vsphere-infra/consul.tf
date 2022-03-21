data "vsphere_virtual_machine" "consul-base" {
  count = var.consul_count
  name          = "consul${count.index}"
  datacenter_id = data.vsphere_datacenter.Homelab.id
}
resource "vsphere_virtual_machine" "consul-prod" {
  count            = var.consul_count
  name             = "consul-prod-${count.index}"
  datastore_id     = data.vsphere_datastore.SDS2.id
  resource_pool_id = data.vsphere_compute_cluster.Main.resource_pool_id
  num_cpus         = 1
  memory           = 1024
  guest_id         = data.vsphere_virtual_machine.consul-base[count.index].guest_id
  scsi_type = data.vsphere_virtual_machine.consul-base[count.index].scsi_type

  network_interface {
    network_id   = data.vsphere_network.vm_net.id
    adapter_type = data.vsphere_virtual_machine.consul-base[count.index].network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.consul-base[count.index].disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.consul-base[count.index].disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.consul-base[count.index].disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.consul-base[count.index].id

    customize {
      linux_options {
        host_name = "consul${count.index}"
        domain    = "lucasquitman.fr"
      }

      network_interface {
        ipv4_address = "192.168.1.24${8 - count.index}"
        ipv4_netmask = 24
      }

      ipv4_gateway = "192.168.1.254"
    }
  }
}