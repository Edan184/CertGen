read -p "Enter RACADM IPs delineated by single spaces: " RACIP
RACIPs=(${RACIP})
read -p "Enter hostname certificate names delineated by single spaces: " Host
Hosts=(${Host})

if [ ${#Hosts[@]} != ${#RACIPs[@]} ]; then
    echo "Ensure the number of RAC IPs match the number of hosts. Exiting..."
    exit 1
fi

for ((i=0; i < ${#Hosts[@]}; i++));

    do 

    echo "Copying local key to remote host"
    racadm -r ${RACIPs[$i]} -i sslkeyupload -t 1 -f keys/${Hosts[$i]}.key

    echo "Copying local cert to remote host"
    racadm -r ${RACIPs[$i]} -i sslcertupload -t 1 -f certs/${Hosts[$i]}.cer

    echo "Restarting RAC"
    racadm -r ${RACIP[$i]} -i racreset

    done