<h1>OpenSSL with brainpool elliptic curves</h1>
<p>For a long time brainpool curves were not supported by OpenSSL. To make use of brainpool curves you had to add them manually. All you have to do is calling OpenSSL with ecparam specifying your favorite elliptic curve parameters explicitly given as described in RFC3279. Newer versions of OpenSSL just support brainpool curves out of the box, see below <a href="#brainpool-native">section</a> for more details.
  
As an example I show you how things gonna look like if you are using the brainpool curve P256r1 (a.k.a. brainpoolP256r1) and want to add this curve by its parameters given as:</p>

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

<p>OpenSSL comes with a handy ASN.1 parser you can use to convert. All we need to do now is converting the ASN.1 structure into DER format:</p>

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

<p>I have created a collection of well known brainpool curves you can import into OpenSSL. Today OpenSSL nativly supports brainpool curves, so there is no need to import them manually, if you turst OpenSSL ;-). If you want to import your own curves, my collection can be a starting point.</p>

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

<h2 id="brainpool-native">How to use OpenSSL's native brainpool implementation</h2>

<p>Newer versions of OpenSSL support brainpool ECC. You can list the supported curves by calling</p>

<pre>openssl ecparam -list_curves</pre>

<p>If your version of OpenSSL supports brainpoolP384r1 you can call</p>

<pre>openssl ecparam -genkey -name brainpoolP384r1 -out Example-Root-CA.key</pre>

<p>to generate a brainpoolP384r1 key.</p>

<p>E.g., to use this key in a self-signed request for a Root-CA just do</p>

<pre>
openssl req -x509 -nodes -sha256 -days 3650 -subj "/CN=Example-Root-CA-2022/O=Example ACME Ltd./C=DE" -addext "keyUsage=critical,keyCertSign:TRUE,cRLSign:TRUE" -key Example-Root-CA.key -out Example-Root-CA.pem
openssl x509 -inform PEM -in Example-Root-CA.pem -outform DER -out Example-Root-CA.crt
</pre>

<p>That's it.</p>
