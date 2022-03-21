output "virtual_machine_infos" {
  value = "${zipmap(
    flatten(tolist(
      vsphere_virtual_machine.nomad.*.name
    )),
    flatten(tolist(
      vsphere_virtual_machine.nomad.*.default_ip_address
    ))
  )}"
}