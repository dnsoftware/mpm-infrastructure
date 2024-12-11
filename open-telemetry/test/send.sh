#!/bin/bash

# отправка запроса в Графану
curl -X POST http://localhost:4328/v1/traces -H'Content-Type: application/json' -d @trace.json