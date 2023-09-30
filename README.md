# CertGen
Used to generate self-signed certificates and imports them to Dell iDRAC using RACADM or VMWare ESXi using SSH to facilitate encrypted connection.
This project is written in BASH shell. 

# Included files
- certGen.sh - generates CA, CSR, and CER files, creates output directories "certs", "keys", and "keys"  
  - Inputs: hostnames, domain; Country, region, city, org, and department for certificate; CSR password

- esxiUpload.sh - imports public certificate and private key to VMWare ESXi host using SSH
  - Inputs: ESXI IPs, domain, hostnames; SSH password

- racadmUpload.sh - imports public certificate and private key to Dell iDRAC host using RACADM
  - Inputs: RACADM IPs, domain, hostnames; RACADM password
 
# Use
Ensure you have a UNIX / LINUX-based environment that supports shell.

- Run certGen.sh
  - Inputs: hostnames, domain; Country, region, city, org, and department for certificate; CSR password

- Depending on whether you are attempting to upload to ESXi or iDRAC, run esxiUpload.sh or racadmUpload.sh

  - For esxiUpload.sh
    - Inputs: ESXI IPs, domain, hostnames; SSH password
  
  - For racadmUpload.sh
    - Inputs: RACADM IPs, domain, hostnames; RACADM password
