output "virtual_machine_infos" {
  value = "${zipmap(
    flatten(tolist(
      vsphere_virtual_machine.glusterfs.*.name
    )),
    flatten(tolist(
      vsphere_virtual_machine.glusterfs.*.default_ip_address
    ))
  )}"
}