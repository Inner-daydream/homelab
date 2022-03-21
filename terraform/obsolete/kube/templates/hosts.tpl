[minion]
%{ for ip in minion ~}
${ip}
%{ endfor ~}

[master]
%{ for ip in master ~}
${ip}
%{ endfor ~}