output "virtual_machine_infos" {
  value = "${zipmap(
    flatten(tolist(
      vsphere_virtual_machine.vault.*.name
    )),
    flatten(tolist(
      vsphere_virtual_machine.vault.*.default_ip_address
    ))
  )}"
}