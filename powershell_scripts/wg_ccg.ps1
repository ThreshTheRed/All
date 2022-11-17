$conf_name = Read-Host -Prompt 'Input config name: '
$full_cnf_name = "$conf_name.conf"
$peer_ip = Read-Host -Prompt 'Input IP Address of a peer: '
$srv_pubkey = Read-Host -Prompt 'Input public key of a server: '
$srv_pubip = Read-Host -Prompt 'Input public IP address of a server: '
New-Item -Path "." -Name "$full_cnf_name" -ItemType "file"

$lines = @("# Client section","[Peer]","PrivateKey = ","AllowedIPs = $peer_ip"," ","# Server section","[Peer]","PublicKey = $srv_pubkey","AllowedIPs = ","Endpoint = $srv_pubip")

foreach ($i in $lines) {
    Add-Content $full_cnf_name $i
}

#
# to do
# create private & public key
# forward their content into correct variables
#
