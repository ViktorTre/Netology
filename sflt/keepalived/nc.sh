#!/bin/bash
[ -f /usr/share/nginx/html/index.html ] && nc -z 192.168.1.5 80

