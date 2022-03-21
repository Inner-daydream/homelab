output "consul_inventory" {
  value = templatefile("../modules/consul/inventory.tpl",
    {
      group_name = "consul_prod"
      consul_map = module.consul.virtual_machine_infos
  })
}
resource "local_file" "consul-inventory" {
  content = templatefile("../modules/consul/inventory.tpl",
    {
      group_name = "consul_prod"
      consul_map = module.consul.virtual_machine_infos
    }
  )
  filename = "../../ansible/inventory/consul-inventory.cfg"
}

output "nomad_inventory" {
  value = templatefile("../modules/nomad/inventory.tpl",
    {
      group_name = "nomad_prod"
      nomad_map  = module.nomad.virtual_machine_infos
  })
}
resource "local_file" "nomad-inventory" {
  content = templatefile("../modules/nomad/inventory.tpl",
    {
      group_name = "nomad_prod"
      nomad_map  = module.nomad.virtual_machine_infos
    }
  )
  filename = "../../ansible/inventory/nomad-inventory.cfg"
}

output "glusterfs_inventory" {
  value = templatefile("../modules/glusterfs/inventory.tpl",
    {
      group_name    = "glusterfs_prod"
      glusterfs_map = module.glusterfs.virtual_machine_infos
  })
}

output "vault_inventory" {
  value = templatefile("../modules/vault/inventory.tpl",
    {
      group_name = "vault_prod"
      vault_map  = module.vault.virtual_machine_infos
  })
}
resource "local_file" "glusterfs-inventory" {
  content = templatefile("../modules/glusterfs/inventory.tpl",
    {
      group_name    = "glusterfs_prod"
      glusterfs_map = module.glusterfs.virtual_machine_infos
    }
  )
  filename = "../../ansible/inventory/glusterfs-inventory.cfg"
}

resource "local_file" "vault-inventory" {
  content = templatefile("../modules/vault/inventory.tpl",
    {
      group_name = "vault_prod"
      vault_map  = module.vault.virtual_machine_infos
    }
  )
  filename = "../../ansible/inventory/vault-inventory.cfg"
}