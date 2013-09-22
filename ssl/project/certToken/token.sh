#CA private key
openssl genrsa -out /etc/keystone/ssl/certs/cakey.pem 1024 -config /etc/keystone/ssl/certs/openssl.conf

#CA certificate
openssl req -new -x509 -extensions v3_ca -passin pass:None -key /etc/keystone/ssl/certs/cakey.pem -out /etc/keystone/ssl/certs/ca.pem -days 3650 -config /etc/keystone/ssl/certs/openssl.conf -subj /C=US/ST=Unset/L=Unset/O=Unset/CN=www.example.com

#Signing private key
openssl genrsa -out /etc/keystone/ssl/private/signing_key.pem 1024 -config /etc/keystone/ssl/certs/openssl.conf

#Signing certificate
openssl req -key /etc/keystone/ssl/private/signing_key.pem -new -nodes -out /etc/keystone/ssl/certs/req.pem -config /etc/keystone/ssl/certs/openssl.conf -subj /C=US/ST=Unset/L=Unset/O=Unset/CN=www.example.com
openssl ca -batch -out /etc/keystone/ssl/certs/signing_cert.pem -config /etc/keystone/ssl/certs/openssl.conf -infiles /etc/keystone/ssl/certs/req.pem

#Token generation and format
openssl cms -sign -signer /etc/keystone/ssl/certs/signing_cert.pem -inkey /etc/keystone/ssl/private/signing_key.pem -outform PEM -nosmimecap -nodetach -nocerts -noattr

openssl cms -sign -signer /etc/keystone/ssl/certs/signing_cert.pem -inkey /etc/keystone/ssl/private/signing_key.pem -outform PEM -nosmimecap -nodetach -nocerts -noattr 


