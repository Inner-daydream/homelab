# generate inventory file for Ansible
resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/templates/hosts.tpl",
    {
      minion = libvirt_cloudinit_disk.minion_init[*].user_data
      master = libvirt_cloudinit_disk.master_init[*].user_data
    }
  )
  filename = "/srv/ansible/inventory/hosts.cfg"
  provisioner "local-exec" {
  command = "echo \"$(cat /srv/ansible/inventory/hosts.cfg | grep -o -e '192.168.1.*/' -e '\\[m.*\\]' | tr -d '/')\" > /srv/ansible/inventory/hosts.cfg"
  interpreter = ["bash", "-c"]
  }
}