# Домашнее задание к занятию «Система мониторинга Zabbix - Третьяков Виктор»

### Цели задания
1. Научиться устанавливать Zabbix Server c веб-интерфейсом
2. Научиться устанавливать Zabbix Agent на хосты
3. Научиться устанавливать Zabbix Agent на компьютер и подключать его к серверу Zabbix 

---

### Задание 1 

Установите Zabbix Server с веб-интерфейсом.


#### Требования к результаты 
1. Прикрепите в файл README.md скриншот авторизации в админке

![task1](/monitoring/zabbix_1/task_1.png)

2. Приложите в файл README.md текст использованных команд в GitHub

apt install postgresql  
wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_6.0-4+debian11_all.deb  
sudo dpkg -i zabbix-release_6.0-4+debian11_all.deb  
apt update  
apt install zabbix-server-pgsql zabbix-frontend-php php7.4-pgsql    zabbix-apache-conf zabbix-sql-scripts zabbix-agent  
sudo -u postgres createuser --pwprompt zabbix  
sudo -u postgres createdb -O zabbix zabbix  
zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix  
nano /etc/zabbix/zabbix_server.conf  
systemctl restart zabbix-server apache2  
systemctl enable zabbix-server apache2  

---

### Задание 2 

Установите Zabbix Agent на два хоста.

#### Требования к результаты 
1. Приложите в файл README.md скриншот раздела Configuration > Hosts, где видно, что агенты подключены к серверу  

![task2_1](/monitoring/zabbix_1/task_2.png)

2. Приложите в файл README.md скриншот лога zabbix agent, где видно, что он работает с сервером  

![task2_2](/monitoring/zabbix_1/task3.png)

3. Приложите в файл README.md скриншот раздела Monitoring > Latest data для обоих хостов, где видны поступающие от агентов данные.  

![task2_3](/monitoring/zabbix_1/task_4.png)

4. Приложите в файл README.md текст использованных команд в GitHub  
tail -f /var/log/zabbix/zabbix_agentd.log  
---
## Задание 3 со звёздочкой*
Установите Zabbix Agent на Windows (компьютер) и подключите его к серверу Zabbix.

#### Требования к результаты 
1. Приложите в файл README.md скриншот раздела Latest Data, где видно свободное место на диске C:
--- 

