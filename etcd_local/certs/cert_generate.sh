#!/bin/bash

# Установить cfssl (если нет)
sudo apt install golang-cfssl -y

# корневой сертификат
cfssl gencert -initca ca-csr.json | cfssljson -bare ca

# Серверный сертификат
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=server server-csr.json | cfssljson -bare server

# Клиентский сертификат
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=client client-csr.json | cfssljson -bare client

# Пировый сертификат
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=peer peer-csr.json | cfssljson -bare peer