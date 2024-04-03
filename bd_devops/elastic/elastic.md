# Домашнее задание к занятию 5. «Elasticsearch» - Третьяков Виктор

## Задача 1

В этом задании вы потренируетесь в:

- установке Elasticsearch,
- первоначальном конфигурировании Elasticsearch,
- запуске Elasticsearch в Docker.

Используя Docker-образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для Elasticsearch,
- соберите Docker-образ и сделайте `push` в ваш docker.io-репозиторий,
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины.

Требования к `elasticsearch.yml`:

- данные `path` должны сохраняться в `/var/lib`,
- имя ноды должно быть `netology_test`.

В ответе приведите:

- текст Dockerfile-манифеста,

```dockerfile
FROM centos:7

RUN yum update -y && \
    yum install curl -y && \
    yum install perl-Digest-SHA -y

ENV ES_DIR="usr/share/elasticsearch"
ENV ES_USER="elasticsearch"

RUN curl -O https://mirror.g-soft.info/elasticsearch/elasticsearch-7.17.12-x86_64.rpm && \
    yum -y localinstall elasticsearch-7.17.12-x86_64.rpm && \
    rm -f elasticsearch-7.17.12-x86_64.prm

RUN mkdir -p /var/lib/elasticsearch

COPY elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

RUN id -u ${ES_USER} &>/dev/null || useradd -m -d ${ES_DIR} elasticsearch

RUN mkdir -p ${ES_DIR}/logs && \
    chown -R elasticsearch:elasticsearch ${ES_DIR} && \
    chmod -R 777 ${ES_DIR}/logs

USER ${ES_USER}

EXPOSE 9200 9300

CMD ["usr/share/elasticsearch/bin/elasticsearch"]
```

![task1](/bd_devops/elastic/task1.png)

- ссылку на образ в репозитории dockerhub,

![dockerhub](https://hub.docker.com/repository/docker/vityatre/vityatre-elastic/general)

- ответ `Elasticsearch` на запрос пути `/` в json-виде.

![task1_2](/bd_devops/elastic/task1_2.png)

## Задача 2

В этом задании вы научитесь:

- создавать и удалять индексы,
- изучать состояние кластера,
- обосновывать причину деградации доступности данных.

Ознакомьтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `Elasticsearch` 3 индекса в соответствии с таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

Получите список индексов и их статусов, используя API, и **приведите в ответе** на задание.

Получите состояние кластера `Elasticsearch`, используя API.

![task2](/bd_devops/elastic/task2.png)

Как вы думаете, почему часть индексов и кластер находятся в состоянии yellow?

потому что если у нас несколько реплик, то их следует размещать на разных нодах, а не как у нас. 

Удалите все индексы.

![task2](/bd_devops/elastic/task2_2.png)

**Важно**

При проектировании кластера Elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

## Задача 3

В этом задании вы научитесь:

- создавать бэкапы данных,
- восстанавливать индексы из бэкапов.

Создайте директорию `{путь до корневой директории с Elasticsearch в образе}/snapshots`.

Используя API, [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
эту директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `Elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`.

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `Elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

Подсказки:

- возможно, вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `Elasticsearch`.

![task3](/bd_devops/elastic/task3_1.png)

![task3](/bd_devops/elastic/task3_2.png)

![task3](/bd_devops/elastic/task3_3.png)

![task3](/bd_devops/elastic/task3_4.png)

![task3](/bd_devops/elastic/task3_5.png)

![task3](/bd_devops/elastic/task3_6.png)
---

```
docker exec -u root -ti cc8 /bin/bash
echo path.repo: "/var/lib/elasticsearch/snapshots" >> /etc/elasticsearch/elasticsearch.yml 
chown elasticsearch:elasticsearch /var/lib/elasticsearch/snapshots
docker restart cc8
curl -X PUT "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d '{"type": "fs","settings": {"location": "/var/lib/elasticsearch/snapshots","compress": true}}'

curl -X PUT "localhost:9200/test?pretty" -H 'Content-Type: application/json' -d' {"settings": {"number_of_shards": 1,"number_of_replicas": 0}}'

curl -X GET 'http://localhost:9200/_cat/indices?v'
curl -X PUT "localhost:9200/_snapshot/netology_backup/snapshot_test?wait_for_completion=true&pretty"

root@3yUbuntu:/var/lib# docker exec -ti cc8 bash
bash-4.2$ cd /var/lib/elasticsearch/snapshots/

curl -X DELETE "localhost:9200/test?pretty"

curl -X PUT "localhost:9200/test-2?pretty" -H 'Content-Type: application/json' -d' {"settings": {"number_of_shards": 1,"number_of_replicas": 0}}'
curl -X GET 'http://localhost:9200/_cat/indices?v'

curl -X GET "localhost:9200/_snapshot/netology_backup/*?verbose=false&pretty"

curl -X POST "localhost:9200/_snapshot/netology_backup/snapshot_test/_restore?pretty" -H 'Content-Type: application/json' -d '{"indices": "test"}'
```