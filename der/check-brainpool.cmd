@echo off
openssl ecparam -inform DER -in brainpoolP160r1.der -check
openssl ecparam -inform DER -in brainpoolP192r1.der -check
openssl ecparam -inform DER -in brainpoolP224r1.der -check
openssl ecparam -inform DER -in brainpoolP256r1.der -check
openssl ecparam -inform DER -in brainpoolP320r1.der -check
openssl ecparam -inform DER -in brainpoolP384r1.der -check
openssl ecparam -inform DER -in brainpoolP512r1.der -check
