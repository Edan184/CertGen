mkdir -p certs; mkdir -p keys; mkdir -p requests; mkdir -p demoCA/newcerts; touch demoCA/index.txt
if [ ! -e "demoCA/serial" ]; then 
    touch demoCA/serial && echo 00 > demoCA/serial
fi
read -p "Enter hostname certificate names delineated by single spaces: " host
hosts=(${host})
read -p "Enter single domain name to suffix end of local hostname: " Domain


if [ ${#Domain} != 0 ]; then
    Domain=.$Domain
fi    

read -p "Enter certificate country: " C
read -p "Enter certificate region or state: " ST
read -p "Enter certificate city: " L
read -p "Enter certificate organization: " O
read -p "Enter certificate department: " OU

for ((i=0; i < ${#hosts[@]}; i++));

    do 

        openssl req -new -x509 -days 3650 -keyout keys/ca-${hosts[$i]}${Domain}.key -out certs/ca-${hosts[$i]}${Domain}.cer -subj "/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=${hosts[$i]}${Domain}"

        openssl req -new -newkey rsa:2048 -nodes -keyout keys/${hosts[$i]}${Domain}.key -out requests/${hosts[$i]}${Domain}.csr -subj "/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=${hosts[$i]}${Domain}"

        openssl ca -policy policy_anything -cert certs/ca-${hosts[$i]}${Domain}.cer -in requests/${hosts[$i]}${Domain}.csr -keyfile keys/ca-${hosts[$i]}${Domain}.key -days 365 -out certs/${hosts[$i]}${Domain}.cer

    done