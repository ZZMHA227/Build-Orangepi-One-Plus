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
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'git clone https://github.com/iwrt/luci-app-ikoolproxy.git package/luci-app-ikoolproxy
echo 'git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
echo 'src-git nas_luci https://github.com/linkease/nas-packages-luci.git;main' >> feeds.conf.default
### 获取额外的 LuCI 应用、主题和依赖 ###
git clone https://github.com/iwrt/luci-app-ikoolproxy.git package/luci-app-ikoolproxy
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
git clone -b master --depth 1 https://github.com/kiddin9/luci-theme-edge package/new/luci-theme-edge
git clone https://github.com/QiuSimons/openwrt-mos/tree/master/mosdns package/new/mosdns
git clone https://github.com/QiuSimons/openwrt-mos/tree/master/luci-app-mosdns package/new/luci-app-mosdns
#CPU控制
svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-cpufreq feeds/luci/applications/luci-app-cpufreq
ln -sf ../../../feeds/luci/applications/luci-app-cpufreq ./package/feeds/luci/luci-app-cpufreq
sed -i 's,1608,1800,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/cpufreq
sed -i 's,2016,2208,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/cpufreq
sed -i 's,1512,1608,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/cpufreq

