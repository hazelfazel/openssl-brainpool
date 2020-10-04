<h1>openssl-brainpool</h1>
<p>For a long time brainpool curves were not supported by OpenSSL. To make use of brainpool curves you had to add them manually. All you have to do is calling OpenSSL with ecparam specifying your favorite elliptic curve parameters explicitly given as described in RFC3279. As an example I show how things gonna look like if you are using the brainpool curve P256r1 (a.k.a. brainpoolP256r1), given as:</p>

<pre>
Prime:                    0x00A9FB57DBA1EEA9BC3E660A909D838D726E3BF623D52620282013481D1F6E5377
A:                        0x7D5A0975FC2C3057EEF67530417AFFE7FB8055C126DC5C6CE94A4B44F330B5D9
B:                        0x26DC5C6CE94A4B44F330B5D9BBD77CBF958416295CF7E1CE6BCCDC18FF8C07B6
Generator (uncompressed): 0x048BD2AEB9CB7E57CB2C4B482FFC81B7AFB9DE27E1E3BD23C23A4453BD9ACE32
                          62547EF835C3DAC4FD97F8461A14611DC9C27745132DED8E545C1D54C72F046997
Order:                    0x00A9FB57DBA1EEA9BC3E660A909D838D718C397AA3B561A6F7901E0E82974856A7
Cofactor:                 0x01
</pre>

<h2>Making the curve parameters ready for OpenSSL</h2>

<p>Encode the parameters above in the format as specified in RFC3279 and save the file as brainpoolP256r1.asn1:</p>

<pre>
asn1=SEQUENCE:ecparams

[ecparams]
no=INTEGER:0x01
prime_field=SEQUENCE:prim
coeff=SEQUENCE:coeffs
generator=FORMAT:HEX,OCTETSTRING:048BD2AEB9CB7E57CB2C4B482FFC81B7AFB9DE27E1E3BD23C23A4453BD9ACE3262547EF835C3DAC4FD97F8461A14611DC9C27745132DED8E545C1D54C72F046997
primeord=INTEGER:0x00A9FB57DBA1EEA9BC3E660A909D838D718C397AA3B561A6F7901E0E82974856A7
cofac=INTEGER:0x01

[prim]
whatitis=OID:prime-field
prime=INTEGER:0x00A9FB57DBA1EEA9BC3E660A909D838D726E3BF623D52620282013481D1F6E5377

[coeffs]
A=FORMAT:HEX,OCTETSTRING:7D5A0975FC2C3057EEF67530417AFFE7FB8055C126DC5C6CE94A4B44F330B5D9
B=FORMAT:HEX,OCTETSTRING:26DC5C6CE94A4B44F330B5D9BBD77CBF958416295CF7E1CE6BCCDC18FF8C07B6
</pre>

<h2>Convert ASN.1 to DER</h2>

<pre>
openssl asn1parse -genconf brainpoolP256r1.asn1 -out brainpoolP256r1.der
</pre>

<p>You can cross check that the elliptic curve parameters are proper by calling</p>

<pre>
openssl ecparam -inform DER -in brainpoolP256r1.der -check
</pre>

<p>If everything was ok you should see something like:</p>

<pre>
checking elliptic curve parameters: ok
-----BEGIN EC PARAMETERS-----
MIHgAgEBMCwGByqGSM49AQECIQCp+1fboe6pvD5mCpCdg41ybjv2I9UmICggE0gd
H25TdzBEBCB9Wgl1/CwwV+72dTBBev/n+4BVwSbcXGzpSktE8zC12QQgJtxcbOlK
S0TzMLXZu9d8v5WEFilc9+HOa8zcGP+MB7YEQQSL0q65y35XyyxLSC/8gbevud4n
4eO9I8I6RFO9ms4yYlR++DXD2sT9l/hGGhRhHcnCd0UTLe2OVFwdVMcvBGmXAiEA
qftX26Huqbw+ZgqQnYONcYw5eqO1Yab3kB4OgpdIVqcCAQE=
-----END EC PARAMETERS-----
</pre>

<p>I have created a collection of well known brainpool curves you can import by OpenSSl. Today OpenSSL nativly supports brainpool curves, so there is no need to import them manually. Maybe this collection is helpful anyway. If you want to import your own curves, my collection can be a starting point.</p>
<p>To generate a key out of a given brainpool curve enter:</p>
<pre>
openssl ecparam -inform DER -in brainpoolP256r1.der -out brainpoolP256r1.key.pem -genkey

openssl ec -in brainpoolP256r1.key.pem -pubout -out brainpoolP256r1.public.key.pem
</pre>
<p>You can generate a elliptic curve based certificate with the following command:</p>
<pre>
openssl req -new -x509 -sha256 -days 356 -key brainpoolP256r1.key.pem -out ca.crt

openssl x509 -in ca.crt -text
</pre>
<p>To sign and verify messages with a given elliptic curve you just enter one of these:</p>
<p>sign with private key:</p>
<pre>
openssl dgst -ecdsa-with-SHA1 -sign brainpoolP256r1.key.pem -out file.txt.ecdsa-with-sha1 file.txt
</pre>
<p>verify with private key:</p>
<pre>
openssl dgst -ecdsa-with-SHA1 -prverify brainpoolP256r1.key.pem -signature file.txt.ecdsa-with-sha1 file.txt
</pre>
<p>verify with public key:</p>
<pre>
openssl dgst -ecdsa-with-SHA1 -verify brainpoolP256r1.public.key.pem -signature file.txt.ecdsa-with-sha1 file.txt
</pre>
