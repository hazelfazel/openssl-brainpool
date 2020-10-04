@echo off
openssl asn1parse -genconf brainpoolP160r1.asn1 -out brainpoolP160r1.der
openssl ecparam -inform DER -in brainpoolP160r1.der -check
openssl ecparam -inform DER -in brainpoolP160r1.der -out brainpoolP160r1.key.pem -genkey

openssl asn1parse -genconf brainpoolP192r1.asn1 -out brainpoolP192r1.der
openssl ecparam -inform DER -in brainpoolP192r1.der -check
openssl ecparam -inform DER -in brainpoolP192r1.der -out brainpoolP192r1.key.pem -genkey

openssl asn1parse -genconf brainpoolP224r1.asn1 -out brainpoolP224r1.der
openssl ecparam -inform DER -in brainpoolP224r1.der -check
openssl ecparam -inform DER -in brainpoolP224r1.der -out brainpoolP224r1.key.pem -genkey

openssl asn1parse -genconf brainpoolP256r1.asn1 -out brainpoolP256r1.der
openssl ecparam -inform DER -in brainpoolP256r1.der -check
openssl ecparam -inform DER -in brainpoolP256r1.der -out brainpoolP256r1.key.pem -genkey

openssl asn1parse -genconf brainpoolP320r1.asn1 -out brainpoolP320r1.der
openssl ecparam -inform DER -in brainpoolP320r1.der -check
openssl ecparam -inform DER -in brainpoolP320r1.der -out brainpoolP320r1.key.pem -genkey

openssl asn1parse -genconf brainpoolP384r1.asn1 -out brainpoolP384r1.der
openssl ecparam -inform DER -in brainpoolP384r1.der -check
openssl ecparam -inform DER -in brainpoolP384r1.der -out brainpoolP384r1.key.pem -genkey

openssl asn1parse -genconf brainpoolP512r1.asn1 -out brainpoolP512r1.der
openssl ecparam -inform DER -in brainpoolP512r1.der -check
openssl ecparam -inform DER -in brainpoolP512r1.der -out brainpoolP512r1.key.pem -genkey
