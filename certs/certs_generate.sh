#!/bin/bash

 openssl genrsa -out cert.key 4096
 openssl req -new -key cert.key -out cert.csr -config csr.conf
 openssl x509 -req -in cert.csr -CA ../cacert/ca.crt -CAkey ../cacert/ca.key -CAcreateserial -out cert.crt -days 3650 -sha256
