#!/usr/bin/env fish

# Activate Python virtual environment for west
source ~/zephyrproject/bin/activate.fish

# Zephyr toolchain config
set -gx ZEPHYR_TOOLCHAIN_VARIANT gnuarmemb
set -gx GNUARMEMB_TOOLCHAIN_PATH /usr
set -gx ZEPHYR_BASE /home/tit4n/zephyrproject/zephyr

