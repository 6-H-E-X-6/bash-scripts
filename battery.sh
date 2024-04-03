#! /bin/bash

# Assign the battery capacity to an
# easily fetched battery variable
battery=$(cat /sys/class/power_supply/BAT0/capacity)

# Assign colours
GREEN=$(echo -en '\001\033[00;32m\002')
YELLOW=$(echo -en '\001\033[00;33m\002')
RED=$(echo -en '\001\033[00;31m\002')
RESET=$(echo -en '\001\033[0m\002')

# Echo current battery level with coloured text
[ $battery -gt 50 ] && echo -e Current battery level: ${GREEN}$battery%${RESET}
[ $battery -le 50 ]&& [ $battery -gt 20 ] && echo -e Current battery level: ${YELLOW}$battery%${RESET}
[ $battery -le 20 ] && echo -e Current battery level: ${RED}$battery%${RESET}
