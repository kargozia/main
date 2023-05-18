#!/bin/bash

# Получение списка аккаунтов и их квоты
quota_info=$(zmprov gqu `zmhostname`)

# Получение списка аккаунтов и их статуса
account_info=$(zmaccts)

# Объединение данных по общему полю (адресу почтового ящика)
echo "$quota_info" | while read -r line; do
    email=$(echo "$line" | awk '{print $1}')
    quota=$(echo "$line" | awk '{printf "%s %.0fMB %.0fMB\n", $1, ($3 / (1024 * 1024)), ($2 / (1024 * 1024))}')
    info=$(echo "$account_info" | awk -v email="$email" '$1 == email {print $2, $3, $4}')
    echo "$quota $info"
done
