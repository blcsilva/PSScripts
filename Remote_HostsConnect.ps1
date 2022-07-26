#Script de conexão em hosts remotos.
clear-host

$hosts = get-content c:\arquivos\hosts.txt



$autenticate = Get-Credential

function connect {

new-PSSession -ComputerName $hosts -Credential $authenticate 

Get-NetIPConfiguration



}

connect

