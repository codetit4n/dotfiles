#!/bin/bash

nvidia-smi --query-gpu=utilization.gpu,temperature.gpu \
           --format=csv,noheader,nounits | \
awk -F', ' '{
    util = $1
    temp = $2
    printf "GPU:%s%% [%s°C]\n", util, temp
}'
