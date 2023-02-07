#!/bin/bash
PREFIX="${1:-NOT_SET}"
INTERFACE="$2"
SUBNET="$3"
HOST="$4"

if [[ ! $(id -nu) =~ root ]]; then
    echo "user must be root"
    exit 1
fi

trap 'echo "Ping exit (Ctrl+C)"; exit 1' 2

[[ "$PREFIX" = "NOT_SET" ]] && { echo "\$PREFIX must be passed as first positional argument"; exit 1; }
if [[ ! $PREFIX =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){1}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then 
    echo "\$PREFIX must be drugoi"
    exit 1
fi
if [[ -z "$INTERFACE" ]]; then
    echo "\$INTERFACE must be passed as second positional argument"
    exit 1
fi
if [[ $(ls /sys/class/net/ | grep -w $INTERFACE | wc -w) == 0 ]]; then
    echo "\takogo INTERFACE v systeme ne obnaruzheno!"
    exit 1
fi

if [[ ! $SUBNET =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|[\s]?)$ ]]; then 
    echo "\$SUBNET must be drugoi"
    exit 1
fi

if [[ ! $HOST =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|[\s]?)$ ]]; then 
    echo "\$HOST must be drugoi"
    exit 1
fi
perebor () 
{
echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/null
}

if [[ $SUBNET =~ ^[\s]?$ ]]; then
for SUBNET in {1..255}; do
	for HOST in {1..255};
	do
	perebor
	done
done

elif [[ $HOST =~ ^[\s]?$ ]]; then
for HOST in {1..255}; do
        perebor
        done

else
perebor
fi
