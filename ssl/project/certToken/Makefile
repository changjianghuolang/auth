IP="192.168.1.105"
PORT="35357"

#TARGETS = private/cakey.pem  cacert.pem req.pem req.pem cert.pem
certkKeystoneDir=/etc/keystone/ssl/certs

TARGETS = private/cakey.pem  cacert.pem req.pem cert.pem  auth_token.signed 

all: $(TARGETS)

cacert.pem  : private/cakey.pem

private/cakey.pem : private
	openssl req -new -x509 -extensions v3_ca -keyout private/cakey.pem -out cacert.pem -days 3650 -config ./keystone.cnf

private :
	mkdir -p private

req.pem:
	openssl req -new -nodes -out req.pem -config ./keystone.cnf


cert.pem : req.pem newcerts index.txt
	openssl ca -out cert.pem -config ./keystone.cnf -infiles req.pem
 

newcerts:
	mkdir newcerts

index.txt :
	echo '01' >serial	
	rm -rf index.txt
	touch index.txt


# Old version

#auth_token.signed : cert.pem auth_token.json

#openssl cms -sign -in auth_token.json -text -out auth_token.signed -signer cert.pem -inkey key.pem
 

# New Version

auth_token.signed : cert.pem auth_token.json
	openssl cms  -sign -in auth_token.json  -nosmimecap  -signer cert.pem -inkey key.pem -outform DER -nodetach -nocerts  -noattr -out auth_token.signed

#Old version, broken
#verify:
#openssl cms -verify -in auth_token.signed  -signer cert.pem -out signedtext.txt -CAfile cacert.pem
 

verify:
	#openssl cms -verify -in auth_token.signed  -certfile cert.pem -CAfile cacert.pem -inform DER -out signedtext.txt  
	#openssl cms -verify -certfile cert.pem -CAfile cacert.pem -inform PEM -nosmimecap -nodetach -nocerts -noattr &lt; cms_token
	openssl cms -verify -in auth_token.signed  -certfile cert.pem -CAfile cacert.pem -inform DER -nosmimecap -nodetach -nocerts -noattr 


display: $(TARGETS)
	openssl x509 -in cacert.pem -noout -text
	openssl x509 -in cacert.pem -noout -dates
	openssl x509 -in cacert.pem -noout -purpose
	openssl req -in req.pem -text -verify -noout
	openssl cms -sign -signer cert.pem -inkey key.pem -outform PEM -nosmimecap -nodetach -nocerts -noattr -in auth_token.signed
	cp ./*.pem $(certkKeystoneDir)/ -rf 
	cp ./auth_token.signed $(certkKeystoneDir)/ -rf 
	openssl cms -sign -signer $(certkKeystoneDir)/cert.pem -inkey $(certkKeystoneDir)/key.pem -outform PEM -nosmimecap -nodetach -nocerts -noattr -in $(certkKeystoneDir)/auth_token.signed
	openssl  cms  -decrypt -in auth_token.signed  -cmsout -inform DER -text

#In order to do check the signature, all of the API endpoints need Keystone certs. These files can be obtained directly from the Keystone Service
curl:
	curl http://localhost:35357/v2.0/certificates/ca
	curl http://localhost:35357/v2.0/certificates/signing
	curl -d '{"auth": {"tenantName": "adminTenant", "passwordCredentials":{"username": "admin", "password": "openstack"}}}' -H "Content-type: application/json" http://$(IP):$(PORT)/v2.0/tokens | python -mjson.tool

 
clean:
	rm -rf $(TARGETS)
	rm -rf ./index.txt

