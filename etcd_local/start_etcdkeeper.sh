#!/bin/bash

./etcdkeeper -usetls=true -auth=true -cacert=certs/ca.pem -p=18080 -cert=certs/client.pem -key=certs/client-key.pem