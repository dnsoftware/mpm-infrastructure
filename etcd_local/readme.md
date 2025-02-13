Сначала нужно сгенерировать комплект сертификатов,
заходим в директорию certs, там в файлах *.json настройки 
для каждого типа сертификатов.

Для этого запускаем cert_generate.sh 

Потом подключаемся к контейнеру и настраиваем пользователя и пароль

### Подключитесь к etcd и создайте пользователя:

docker exec -it etcd1 etcdctl \
--cert=/etc/etcd/certs/client.pem \
--key=/etc/etcd/certs/client-key.pem \
--cacert=/etc/etcd/certs/ca.pem \
user add root --new-user-password=securepassword

### Включите аутентификацию:

docker exec -it etcd1 etcdctl \
--cert=/etc/etcd/certs/client.pem \
--key=/etc/etcd/certs/client-key.pem \
--cacert=/etc/etcd/certs/ca.pem \
auth enable

### Добавляем роль пользователю:
docker exec -it etcd1 etcdctl \
--cert=/etc/etcd/certs/client.pem \
--key=/etc/etcd/certs/client-key.pem \
--cacert=/etc/etcd/certs/ca.pem --user=root:securepassword \
role add root

### Назначаем роль пользователю:
docker exec -it etcd1 etcdctl \
--cert=/etc/etcd/certs/client.pem \
--key=/etc/etcd/certs/client-key.pem \
--cacert=/etc/etcd/certs/ca.pem --user=root:securepassword \
user grant-role root root

# Проверка доступности кластера

docker exec -it etcd1 etcdctl \
--cert=/etc/etcd/certs/client.pem \
--key=/etc/etcd/certs/client-key.pem \
--cacert=/etc/etcd/certs/ca.pem --user=root:securepassword \
member list

должно вывести, чтото типа:
1f6fd35e3327767a, started, etcd1, https://etcd1:2380, https://etcd1:2379, false
2a6277f8728ef760, started, etcd3, https://etcd3:2380, https://etcd3:2379, false
4acd0a1e9189cd7a, started, etcd2, https://etcd2:2380, https://etcd2:2379, false


# Проверка etcd добавления ключа
# Добавление

docker exec -it etcd1 etcdctl \
--cert=/etc/etcd/certs/client.pem \
--key=/etc/etcd/certs/client-key.pem \
--cacert=/etc/etcd/certs/ca.pem --user=root:securepassword \
put mykey "Hello, etcd!"

# чтение

docker exec -it etcd1 etcdctl \
--cert=/etc/etcd/certs/client.pem \
--key=/etc/etcd/certs/client-key.pem \
--cacert=/etc/etcd/certs/ca.pem --user=root:securepassword \
get mykey

-----
# параметры запуска etcdkeeper из командной строки (для теста работоспособности)
# с сертификатами и авторизацией
# в случае, если в docker-compose запустить не получилось
./etcdkeeper -usetls=true -auth=true -cacert=certs/ca.pem -p=18080 -cert=certs/client.pem -key=certs/client-key.pem
