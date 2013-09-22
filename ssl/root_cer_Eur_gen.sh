openssl genrsa -out private/ca.key.pem 2048
#openssl genrsa -des3 -out private/ca.key.pem 2048
openssl req -new -key private/ca.key.pem -out certs/ca.req.pem  -subj "/C=US/O=tComLabs - Euro-DOCSIS/OU=Cable Modems/CN=Euro-DOCSIS Cable Modem Root CA"
openssl x509 -req -days 1000 -sha1 -extfile ./openssl.cnf -extensions v3_ca -signkey private/ca.key.pem -in certs/ca.req.pem -out certs/ca.crt.pem  
./openssl_format_pem2der.sh certs/ca.crt.pem certs/mfg.cer
#cp /home/ssl/certs/mfg.cer /srv/tftp/
