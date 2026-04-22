#!/bin/bash
# Modify version and ip
# 此脚本在 openwrt/ 目录下运行，在 feeds install 之后执行
curl -sSL https://raw.githubusercontent.com/mufeng05/turboacc/main/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh

# Modify default IP
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate

# Modify version
sed -i 's/OpenWrt/DeepWrt/g' package/base-files/image-config.in
sed -i 's/OpenWrt/DeepWrt/g' include/version.mk
sed -i 's/OpenWrt/DeepWrt/g' package/base-files/files/bin/config_generate
