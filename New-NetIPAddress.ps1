clear-host

Write-host "Script de configuração de interface de redes"

Get-NetAdapter | Where-Object -Property Status -eq -Value 'up'



$interface = read-host "Digite o número da interface (ifIndex)"


$netAdapter = Get-NetAdapter -InterfaceIndex $interface

Write-host "Definindo endereço IP"

$IPAddress = read-host "Digite o endreço IP:"
$PrefixLength = read-host "Digite o endreço PrefixLength:"
$DefaultGateway = read-host "Digite o endreço Default Gateway:"

Write-host "Definindo servidores de DNS:"

$DNSServer1 = read-host "Digite o endreço IP"
$DNSServer2 = read-host "Digite o endreço IP"


Remove-NetIPAddress -InterfaceIndex $netAdapter.ifIndex -AddressFamily 'IPv4'


Remove-NetRoute -InterfaceIndex $netAdapter.ifIndex -AddressFamily 'IPv4'




$NetIPAddress = @{
    InterfaceIndex = $netAdapter.ifIndex
    AddressFamily = 'IPv4'
    IPAddress = $IPAddress
    PrefixLength = $PrefixLength
    DefaultGateway = $DefaultGateway
}
New-NetIPAddress @NetIPAddress



Set-DnsClientServerAddress -InterfaceIndex $netAdapter.ifIndex -ServerAddresses @('$DNSServer1','$DNSServer2')
Get-NetIPConfiguration -InterfaceIndex $netAdapter.ifIndex