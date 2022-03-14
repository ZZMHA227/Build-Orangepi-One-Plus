#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.5.2/g' package/base-files/files/bin/config_generate

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-argonv3/g' feeds/luci/collections/luci/Makefile

# Add date version
export DATE_VERSION=$(date -d "$(rdate -n -4 -p pool.ntp.org)" +'%Y-%m-%d')
sed -i "s/%C/%C (${DATE_VERSION})/g" package/base-files/files/etc/openwrt_release

# Rename hostname to OpenWrt
pushd package/base-files/files/bin
sed -i 's/ImmortalWrt/OpenWrt/g' config_generate
popd

#One Plus CPU 调节
#git clone --depth=1 https://github.com/ZZMHA227/OOP-CPU.git ./package/target/linux/sunxi/patches-5.4/102-arm64-dts-allwinner-h6-Enable-CPU-opp-tables-for-orangepi.patch
wget https://github.com/ZZMHA227/OOP-CPU/raw/main/102-arm64-dts-allwinner-h6-Enable-CPU-opp-tables-for-orangepi.patch -O ./package/target/linux/sunxi/patches-5.4/102-arm64-dts-allwinner-h6-Enable-CPU-opp-tables-for-orangepi.patch

