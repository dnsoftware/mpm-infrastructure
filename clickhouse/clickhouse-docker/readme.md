### ClickHouse кластер в docker-compose

- Три ноды clickhouse
- Три ноды zookeeper
- Клиент может подключаться и писать в любую реплику
- ZOO_MY_ID в docker-compose мапяться в файл zookeepN/data/myid. Проверять чтобы были разные числа, если zookeeper глючит и не стартует имеет смысл очистить data директории
- Пользователь Clickhouse default задается в docker-compose
- остальные пользователи (в частности mpmhouse) задается в конфиге users.xml
- Рабочая база данных развертывается в миграциях клиента (в нашем случае в микросервисе mpm-shares-timeseries)
- Для реплицируемости важно делать запросы к кластеру (например: CREATE DATABASE IF NOT EXISTS mpmhouse ON CLUSTER clickhouse_cluster;)
- при создании таблиц указывать "ENGINE = ReplicatedMergeTree"