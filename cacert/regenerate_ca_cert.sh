#!/bin/bash

# Запрашиваем подтверждение
read -p "Вы уверены, что хотите продолжить? (y/n): " answer

# Проверяем ответ пользователя
if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo "Скрипт отменен."
    exit 1
else
    echo "Продолжаем выполнение скрипта..."
fi

openssl genpkey -algorithm RSA -out ca.key -pkeyopt rsa_keygen_bits:4096
openssl req -x509 -new -key ca.key -out ca.crt -days 3650 -config openssl.cnf

