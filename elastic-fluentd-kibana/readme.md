## Установка и настройка стека EFK + Kafka

### Серия статей:

https://habr.com/ru/articles/538840/

https://habr.com/ru/post/538974/

https://habr.com/ru/articles/540606/

### Работаем в локальной директории efk/elasticsearch-ansible

### Установка Elasticsearch

Так как доступ к репозиторию эластика заблокирован из России, нужно предварительно скачать пакет на локальный комп, а потом с помошью Ansible скопировать и установить Elasticsearch на всех узлах кластера

Скачиваем:

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.16.1-amd64.deb

- копируем пакет в elasticsearch-ansible
- запускаем плейбук копирования и установки:
  - ansible-playbook copy_elastic.yaml
  

- Запускаем основной плейбук: 
  - ansible-playbook playbook.yaml


## Установка Kibana

Так как доступ к репозиторию Kibana заблокирован из России, нужно предварительно скачать пакет на локальный комп, а потом с помошью Ansible скопировать и установить Kibana на нужных серверах

Скачиваем:

wget https://artifacts.elastic.co/downloads/kibana/kibana-8.16.1-amd64.deb

- копируем пакет в kibana-ansible
- запускаем плейбук копирования и установки:
  - ansible-playbook copy_kibana.yaml


- Запускаем основной плейбук:
  - ansible-playbook playbook.yaml


## Установка fluentbit

### Статьи по настройке:
https://blog.yakunin.dev/fluent-bit-docker-install/
https://habr.com/ru/articles/548998/

### Первый вариант сделал через docker-compose:
смотри директорию efk/fluentbit-docker


Важно: в конфиге td-agent-bit.conf комментарии должны быть только на новой строке:

Path /tmp/test.log # такой комментарий недопустим

правильно:

  #такой комментарий допустим

  Path /tmp/test.log 

Важно: В секции [OUTPUT] конфига обязательно указать параметр:

Suppress_Type_Name On

а то вылазят ошибки

----

На локалке конфиг смотри в /etc/td-agent-bit/fluent-bit.conf

Запуск в консоли:

/opt/td-agent-bit/bin/td-agent-bit -c //etc/td-agent-bit/td-agent-bit.conf

---
### Вариант на удаленном сервере - удалось установить через Ansible только путем запуска скрипта:

curl https://raw.githubusercontent.com/fluent/fluent-bit/master/install.sh | sh

из официального мануала: https://docs.fluentbit.io/manual/installation/linux/ubuntu

Плейбук смотри в папке fluentbit-ansible

----



----