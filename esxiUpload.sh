read -p "Enter ESXi SSH IPs delineated by single spaces: " ESXiIP
ESXiIPs=(${ESXiIP})
read -p "Enter single domain name to suffix end of local hostname: " Domain
Domains=${Domain}
read -p "Enter local hostname certificate names delineated by single spaces respective to ESXi IPs: " Host
Hosts=(${Host})

if [ ${#Hosts[@]} != ${#ESXiIPs[@]} ]; then
    echo "Ensure the number of ESXi IPs match the number of hosts. Exiting..."
    exit 1
fi

if [ ${#Domain} != 0 ]; then
    Domain=.$Domain
fi    

read -p "SSH username: " User

for ((i=0; i < ${#Hosts[@]}; i++));

    do 
    echo "Processing ${Hosts[$i]}$Domain at ${ESXiIPs[$i]}"
    echo "Suffixing old credentials with .BAK"
    ssh $User@${ESXiIPs[$i]} "mv /etc/vmware/ssl/rui.crt /etc/vmware/ssl/rui.crt.BAK; mv /etc/vmware/ssl/rui.key /etc/vmware/ssl/rui.key.BAK"

    echo "Copying local cert to remote host certs/${Hosts[$i]}$Domain.cer"
    scp certs/${Hosts[$i]}$Domain.cer $User@${ESXiIPs[$i]}:/etc/vmware/ssl/rui.crt

    echo "Copying local key to remote host keys/${Hosts[$i]}$Domain.key"
    scp keys/${Hosts[$i]}$Domain.key $User@${ESXiIPs[$i]}:/etc/vmware/ssl/rui.key

    read -p "Would you like to restart you ESXi host now (y/n)" Restart
    if [ $Restart = 'y' ]; then

        echo "Restarting ESXi host"
        ssh $User@${ESXiIPs[$i]} "reboot"

    fi

    done