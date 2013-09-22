all:Eur US
Eur:
	./root_cer_Eur_gen.sh
	./cm_cer.sh
US:
	./root_cer_US_gen.sh
	./cm_cer.sh
clean:
	rm private/*.p8 private/*.pem
	rm certs/*.cer certs/*.pem 
