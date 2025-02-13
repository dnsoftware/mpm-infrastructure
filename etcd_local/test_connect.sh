#!/bin/bash

# Тест кластера etcd на работоспособность
# Ответ должен выглядеть: {"health":"true"}

curl --cert certs/client.pem --key certs/client-key.pem --cacert certs/ca.pem --silent --request GET --url https://127.0.0.1:2379/health
