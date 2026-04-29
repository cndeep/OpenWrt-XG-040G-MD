#!/bin/bash
# Modify files and add app
# 此脚本在 openwrt/ 目录下运行，在 feeds install 之后执行
curl -sSL https://raw.githubusercontent.com/mufeng05/turboacc/main/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh
git clone --depth=1 https://github.com/laipeng668/luci-app-gecoosac package/luci-app-gecoosac
git clone --depth=1 https://github.com/FUjr/QModem package/QModem
git clone --depth=1 https://github.com/rchen14b/luci-app-airoha-npu.git package/luci-app-airoha-npu
git clone --depth=1 https://github.com/gSpotx2f/luci-app-temp-status package/luci-app-temp-status
git clone --depth=1 https://github.com/gSpotx2f/luci-app-cpu-perf package/luci-app-cpu-perf

# Modify default IP
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate

# Modify version
sed -i 's/OpenWrt/DeepWrt/g' package/base-files/image-config.in
sed -i 's/OpenWrt/DeepWrt/g' include/version.mk
sed -i 's/OpenWrt/DeepWrt/g' package/base-files/files/bin/config_generate

mkdir -p "package/base-files/files/etc/uci-defaults"
cp -f "../patch/99_fix-airoha-mac" "package/base-files/files/etc/uci-defaults/99_fix-airoha-mac"
cp -f "../patch/sysctl-nf-conntrack.conf" "package/kernel/linux/files/sysctl-nf-conntrack.conf"

sed -i 's|include ../../luci.mk|include $(TOPDIR)/feeds/luci/luci.mk|' package/luci-app-airoha-npu/Makefile
sed -i 's/PKG_VERSION:=1.13.11/PKG_VERSION:=1.12.25/' package/sing-box/Makefile
sed -i 's/PKG_HASH:=5e35f2cc0ad14d3beb1956157fe3f4b3a36787dd115f247c72f2d550d353853b/PKG_HASH:=881435f07b5ab8170ccf3cb69e87130759521dc0ed1ae4bfeacbe7772a93a158/' package/sing-box/Makefile