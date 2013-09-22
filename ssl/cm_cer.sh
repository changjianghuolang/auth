openssl genrsa -out private/cm.key.pem 1024
openssl req -new -key private/cm.key.pem -out certs/cm.req.pem -subj "/C=US/O=SMC Networks Inc./OU=SuZhou New District, Jiangsu, P.R.C./CN=78:CD:8E:A8:8A:68"
openssl x509 -req -days 100 -sha1 -extfile openssl.cnf -extensions usr_cert -CA certs/ca.crt.pem -CAkey private/ca.key.pem -CAserial ca.srl -CAcreateserial -in certs/cm.req.pem -out certs/cm.crt.pem  
./openssl_format_pem2der.sh certs/cm.crt.pem certs/cm.cer
#cp ./certs/cm.cer /srv/tftp/
