#!/bin/bash
rsync -azvh --delete /home/tretyakov /tmp/backup
if [[ $? -eq 0 ]]; then
logger "rezervnaya copy was been created"
else
logger "reserved copy wasn't been created"
fi;
