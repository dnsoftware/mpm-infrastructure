
Важно (на локалке, а может и на сервере) выставить настройку elasticsearch (иначе на локалке не запускалось: high disk watermark [90%] exceeded on):

environment:
- cluster.routing.allocation.disk.threshold_enabled=false
