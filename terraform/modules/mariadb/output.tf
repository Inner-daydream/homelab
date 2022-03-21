output "virtual_machine_infos" {
  value = "${zipmap(
    flatten(tolist(
      vsphere_virtual_machine.consul.*.name
    )),
    flatten(tolist(
      vsphere_virtual_machine.consul.*.default_ip_address
    ))
  )}"
}