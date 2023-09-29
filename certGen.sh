mkdir -p certs; mkdir -p keys; mkdir -p requests; mkdir -p demoCA/newcerts; touch demoCA/index.txt
if [ ! -e "demoCA/serial" ]; then 
    touch demoCA/serial && echo 00 > demoCA/serial
fi
read -p "Enter hostname certificate names delineated by single spaces: " Host
Hosts=(${Host})
read -p "Enter single domain name to suffix end of local hostname: " Domain


if [ ${#Domain} != 0 ]; then
    Domain=.$Domain
fi    

read -p "Enter certificate country: " C
read -p "Enter certificate region or state: " ST
read -p "Enter certificate city: " L
read -p "Enter certificate organization: " O
read -p "Enter certificate department: " OU

for ((i=0; i < ${#Hosts[@]}; i++));

    do 
        echo "Processing certificate for ${Hosts[$i]}${Domain}"
        openssl req -new -x509 -days 3650 -keyout keys/ca-${Hosts[$i]}${Domain}.key -out certs/ca-${Hosts[$i]}${Domain}.cer -subj "/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=${Hosts[$i]}${Domain}"

        openssl req -new -newkey rsa:2048 -nodes -keyout keys/${Hosts[$i]}${Domain}.key -out requests/${Hosts[$i]}${Domain}.csr -subj "/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=${Hosts[$i]}${Domain}"

        openssl ca -policy policy_anything -cert certs/ca-${Hosts[$i]}${Domain}.cer -in requests/${Hosts[$i]}${Domain}.csr -keyfile keys/ca-${Hosts[$i]}${Domain}.key -days 365 -out certs/${Hosts[$i]}${Domain}.cer

    done