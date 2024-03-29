# Домашнее задание к занятию «Подъём инфраструктуры в Yandex Cloud» - Третьяков Виктор

### Задание 1 

**Выполните действия, приложите скриншот скриптов, скриншот выполненного проекта.**

От заказчика получено задание: при помощи Terraform и Ansible собрать виртуальную инфраструктуру и развернуть на ней веб-ресурс. 
В инфраструктуре нужна одна машина с ПО ОС Linux, двумя ядрами и двумя гигабайтами оперативной памяти. 


Требуется установить nginx, залить при помощи Ansible конфигурационные файлы nginx и веб-ресурса. 

![terraform](https://github.com/ViktorTre/Netology/tree/main/cicd/yandexcloud/terraform)

![вывод терраформ](/cicd/yandexcloud/terraform.png)

![ycnginx.yml](https://github.com/ViktorTre/Netology/tree/main/cicd/yandexcloud/ycnginx.yml)

![role nginx](https://github.com/ViktorTre/Netology/tree/main/cicd/yandexcloud/nginx)

![вывод ansible](/cicd/yandexcloud/ansible.png)

Провести тестирование. 

![вывод nginx](/cicd/yandexcloud/nginx.png)
---

## Дополнительные задания* (со звёздочкой)

Их выполнение необязательное и не влияет на получение зачёта по домашнему заданию. Можете их решить, если хотите лучше разобраться в материале.лнить, если хотите глубже и/или шире разобраться в материале.

--- 
### Задание 2*

**Выполните действия, приложите скриншот скриптов, скриншот выполненного проекта.**

1. Перестроить инфраструктуру и добавить в неё вторую виртуальную машину. 
2. Установить на вторую виртуальную машину базу данных. 
3. Выполнить проверку состояния запущенных служб через Ansible.

---

Дополнительные материалы: 

1. [Nginx. Руководство для начинающих](https://nginx.org/ru/docs/beginners_guide.html). 
2. [Руководство по Terraform](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/doc). 
3. [Ansible User Guide](https://docs.ansible.com/ansible/latest/user_guide/index.html).
1. [Terraform Documentation](https://www.terraform.io/docs/index.html).

