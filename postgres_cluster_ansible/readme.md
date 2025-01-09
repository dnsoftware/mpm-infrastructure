### Кластер Postgresql+pgbouncer+patroni+haproxy

Используется сторонний etcd кластер (смотри настройку в etcd-ansible)

 - ставим HAproxy: ansible-playbook haproxy.yaml
 - ставим кластер Postgresql+pgbouncer+patroni: ansible-playbook ppp.yaml
 - заводим нужного пользователя, БД, даем права: ansible-playbook create_db.yaml
 - в плейбуке ppp.yaml не забыть прописать нужных пользователей для работы с базой, смотри таск “Добавление пользователей PgBouncer”, это прям важно, иначе не будет работать.

----

Автоматический failover тест (для Patroni)

Чтобы убедиться, что реплика действительно может стать мастером:

    - Остановите текущий мастер: systemctl stop patroni (имя ноды мастера, которое можно увидеть с помощью команды: patronictl -c patroni.yml list)
    - Проверьте, что Patroni автоматически переключил реплику в мастера с помощью команды patronictl -c patroni.yml list (в директории с конфигом).
    - Подключитесь к новому мастеру и убедитесь, что он принимает записи.

---

Создаем базу данных mpmpool, пользователя mpmpool с паролем mpmpoolpass
Все это через Ansible

---

### Команды администрирования 
// Адреса нод кластера
62.113.106.101
31.129.106.65
31.128.36.206

// ssh логин и копирование ssh ключа на сервер
ssh root@62.113.106.101
ssh-copy-id -i ~/.ssh/id_ed25519.pub root@62.113.106.101
c*UcSbMys4Fj

ssh root@31.129.106.65
ssh-copy-id -i ~/.ssh/id_ed25519.pub root@31.129.106.65
6tRL6RtNNS%F

ssh root@31.128.36.206
ssh-copy-id -i ~/.ssh/id_ed25519.pub root@31.128.36.206
J3esl&rVFd3v

// Список нод кластера postgresql
// консольная команда на любой ноде кластера
patronictl -c /etc/patroni/patroni.yml list

systemctl restart patroni

------------

Коннект к базам в pgAdmin настраивается к портам HAproxy. Их два, как основной используем какой-то один

Порт 6532 - для мастер-запросов (запросы, изменяющие данные)
Порт 6533 - для реплика запросов (только запросы на чтение)

-------------
