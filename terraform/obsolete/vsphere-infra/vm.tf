// data "vsphere_virtual_machine" "rundeck_template" {
//   name          = "rundeck_base"
//   datacenter_id = data.vsphere_datacenter.Homelab.id
// }
// resource "vsphere_virtual_machine" "rundeck_prod" {
//   name             = "rundeck_prod"
//   datastore_id     = data.vsphere_datastore.SDS1.id
//   resource_pool_id = data.vsphere_compute_cluster.Main.resource_pool_id
//   num_cpus         = 2
//   memory           = 4096
//   guest_id         = data.vsphere_virtual_machine.rundeck_template.guest_id

//   scsi_type = data.vsphere_virtual_machine.rundeck_template.scsi_type

//   network_interface {
//     network_id   = data.vsphere_network.vm_net.id
//     adapter_type = data.vsphere_virtual_machine.rundeck_template.network_interface_types[0]
//   }

//   disk {
//     label         = "disk0"
//     size          = data.vsphere_virtual_machine.rundeck_template.disks.0.size
//     eagerly_scrub = data.vsphere_virtual_machine.rundeck_template.disks.0.eagerly_scrub
//     thin_provisioned = data.vsphere_virtual_machine.rundeck_template.disks.0.thin_provisioned
//   }

//   clone {
//     template_uuid = data.vsphere_virtual_machine.rundeck_template.id

//     customize {
//       linux_options {
//         host_name = "rundeck"
//         domain    = "lucasquitman.fr"
//       }

//       network_interface {
//         ipv4_address = "192.168.1.150"
//         ipv4_netmask = 24
//       }

//       ipv4_gateway = "192.168.1.254"
//     }
//   }
// }