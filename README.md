# CertGen
Used to generate self-signed certificates with OpenSSL and import them to Dell iDRAC using RACADM or VMWare ESXi using SSH to facilitate encrypted connection.
This project is written in BASH shell. 

## Included files
- **certGen.sh** - generates CA, CSR, and CER files, creates output directories "certs", "keys", and "keys"  
  - Inputs: hostnames, domain; Country, region, city, org, and department for certificate; CSR password

- **esxiUpload.sh** - imports public certificate and private key to VMWare ESXi host using SSH
  - Inputs: ESXI IPs, domain, hostnames; SSH password

- **racadmUpload.sh** - imports public certificate and private key to Dell iDRAC host using RACADM
  - Inputs: RACADM IPs, domain, hostnames; RACADM password
 
## Installation

Ensure you have a UNIX / LINUX-based environment that supports shell and have OpenSSL installed within that environment.

Run: ``sudo apt-get install openssl``

 
## Use
- Run ```sh certGen.sh```
  - Inputs: hostnames, domain; Country, region, city, org, and department for certificate; CSR password
  - Input **hostnames** are delineated by spaces

- Depending on whether you are attempting to upload to ESXi or iDRAC:

  - For ESXi upload,  run ```sh esxiUpload.sh```
    - Inputs: ESXI IPs, domain, hostnames; SSH password
      - Inputs ***ESXiIPs*** and ***hostnames*** are delineated by spaces, type in-line

  - For iDRAC upload, run ```sh racadmUpload.sh```
    - Inputs: RACADM IPs, domain, hostnames; RACADM password
      - Inputs ***RACIPs*** and ***hostnames*** are delineated by spaces, type in-line
