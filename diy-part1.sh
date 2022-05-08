#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git" >> "feeds.conf.default"
echo "src-git passwallluci https://github.com/xiaorouji/openwrt-passwall.git;luci" >> "feeds.conf.default"
echo "src-git bypass https://github.com/kiddin9/openwrt-bypass.git" >> "feeds.conf.default"

#One Plus CPU 调节
git clone --depth=1 https://github.com/ZZMHA227/OOP-CPU.git ./target/linux/sunxi/patches-5.4/102-arm64-dts-allwinner-h6-Enable-CPU-opp-tables-for-orangepi.patch
#wget https://github.com/immortalwrt/immortalwrt/blob/726cbc3b62695eb890ef2d2b5074d751cb6d9494/target/linux/sunxi/patches-5.4/103-arm64-dts-allwinner-h6-Enable-CPU-opp-tables-for-orangepi.patch -O ./target/linux/sunxi/patches-5.4/103-arm64-dts-allwinner-h6-Enable-CPU-opp-tables-for-orangepi.patch
