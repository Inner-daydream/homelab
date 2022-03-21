[${group_name}]
%{for host_name, ip in vault_map ~}
${ host_name } ansible_host=${ip}
%{ endfor ~}