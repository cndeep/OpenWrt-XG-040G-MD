#!/bin/bash
# Modify files and add app
# 此脚本在 openwrt/ 目录下运行，在 feeds install 之后执行
curl -sSL https://raw.githubusercontent.com/mufeng05/turboacc/main/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh
git clone --depth=1 https://github.com/laipeng668/luci-app-gecoosac package/luci-app-gecoosac
git clone --depth=1 https://github.com/FUjr/QModem package/QModem
git clone --depth=1 https://github.com/rchen14b/luci-app-airoha-npu.git package/luci-app-airoha-npu

# Modify default IP
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate

# Modify version
sed -i 's/OpenWrt/DeepWrt/g' package/base-files/image-config.in
sed -i 's/OpenWrt/DeepWrt/g' include/version.mk
sed -i 's/OpenWrt/DeepWrt/g' package/base-files/files/bin/config_generate

mkdir -p "package/base-files/files/etc/uci-defaults"
cp -f "../patch/99_fix-airoha-mac" "package/base-files/files/etc/uci-defaults/99_fix-airoha-mac"