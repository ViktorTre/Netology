#!/bin/bash

INTERFACE="$1"

if [[ ! $(id -nu) =~ root ]]; then
    echo "user must be root"
    exit 1
fi

trap 'echo "Ping exit (Ctrl+C)"; exit 1' 2

if [[ -z "$INTERFACE" ]]; then
    echo "\$INTERFACE must be passed as second positional argument"
    exit 1
fi

if [[ $(ls /sys/class/net/ | grep -w $INTERFACE | wc -w) == 0 ]]; then
    echo "\takogo INTERFACE v systeme ne obnaruzheno!"
    exit 1
fi

result=$(ip -br a show | grep $INTERFACE | awk '{print$3}' | cut -d '.' -f 1,2,3)
maska=$(ip -br a show | grep $INTERFACE | awk '{print$3}' | cut -d '/' -f 2)
    echo $result $maska
    

perebor () 
{
echo "[*] IP : ${result}.${HOST}"
arping -c 3 -i "$INTERFACE" "${result}.${HOST}" 2> /dev/null
}

for HOST in {1..255}; do
        perebor
        done
