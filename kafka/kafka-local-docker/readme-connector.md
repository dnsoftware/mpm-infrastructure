## cp-kafka-connect

Для коннектора кафки с elasticsearch должны быть созданы системные топики в kafka:

connect-offsets (Cleanup policy = compact)
connect-configs
connect-statuses

Если не создались автоматически - создаем руками 

### Внимание: заметки выше не используются, так как в качестве коннектора из кафки в эластик в docker-compose встроен Logstash - смотри logstash.conf


