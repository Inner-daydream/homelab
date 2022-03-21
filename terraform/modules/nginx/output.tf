output "virtual_machine_infos" {
  value = "${zipmap(
    flatten(tolist(
      vsphere_virtual_machine.nginx.*.name
    )),
    flatten(tolist(
      vsphere_virtual_machine.nginx.*.default_ip_address
    ))
  )}"
}