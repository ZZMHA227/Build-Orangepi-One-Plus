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
function merge_package(){
    pn=`echo $1 | rev | cut -d'/' -f 1 | rev`
    find package/ -follow -name $pn -not -path "package/custom/*" | xargs -rt rm -r
    if [ ! -z "$2" ]; then
        find package/ -follow -name $2 -not -path "package/custom/*" | xargs -rt rm -r
    fi

    if [[ $1 == *'/trunk/'* || $1 == *'/branches/'* ]]; then
        svn export $1
    else
        git clone --depth=1 --single-branch $3 $1
        rm -rf $pn/.git
    fi
    mv $pn package/custom/
}
function drop_package(){
    find package/ -follow -name $1 -not -path "package/custom/*" | xargs -rt rm -r
}
function merge_feed(){
    if [ ! -d "feed/$1" ]; then
        echo >> feeds.conf.default
        echo "src-git $1 $2" >> feeds.conf.default
    fi
    ./scripts/feeds update $1
    ./scripts/feeds install -a -p $1
}

rm -rf package/custom; mkdir package/custom
merge_package https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav
merge_package https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav
merge_package https://github.com/small-5/luci-app-adblock-plus
