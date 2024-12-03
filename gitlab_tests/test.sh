#!/bin/bash

# Значение токена для авторизации
TOKEN="your_token_here"

# Выполняем запрос и сохраняем результат в переменную response
response=$(curl -s -H "Authorization: Bearer ${TOKEN}" "https://mail.ru")

VAULT_TOKEN="ttt"
CA_CERT=$(curl -k -s --header "X-Vault-Token: ${VAULT_TOKEN}" "https://mail.ru" | jq -r .data.value)


# Выводим результат
echo "$CA_CERT"

