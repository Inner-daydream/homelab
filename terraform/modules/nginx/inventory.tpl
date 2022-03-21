[${group_name}]
%{for host_name, ip in nginx_map ~}
${ host_name } ansible_host=${ip}
%{ endfor ~}