#!/bin/bash

readonly BROKER=${BROKER:-kafka.sbx8.bip.va.gov}
readonly TOPIC=${TOPIC:-bip-ventinfo-pi-demo}

NAME_LIST=(
    Liam
    Noah
    Oliver
    William
    Elijah
    James
    Benjamin
    Lucas
    Mason
    Ethan
    Olivia
    Emma
    Ava
    Sophia
    Isabella
    Charlotte
    Amelia
    Mia
    Harper
    Evelyn
)

for name in ${NAME_LIST[@]}
do
    rand=$[$RANDOM % ${#NAME_LIST[@]}]
    echo "Hello, ${NAME_LIST[$rand]}" | kafkacat -F /kafka.config -b ${BROKER} -t ${TOPIC}
    sleep $((1 + $RANDOM % 5))s
done
