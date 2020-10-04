<h1>openssl-brainpool</h1>
<p>For a long time brainpool curves were not supported by OpenSSL. To make use of brainpool curves you have to add them manually. Thus I have created a collection of well known brainpool curves you can import by OpenSSl. Today OpenSSL nativly supports brainpool curves, so there is no need to import them manually. Maybe this collection is helpful anyway. If you want to import your own curves, my collection can be a starting point.</p>
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
