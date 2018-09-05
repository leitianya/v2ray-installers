#!/bin/bash

GREEN="\033[32m"
RED="\033[31m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
FONT="\033[0m"

INFO="${GREEN}[信息]${FONT}"
ERROR="${RED}[错误]${FONT}"

V2RAY_CONFIG_PATH="/etc/v2ray"
V2RAY_CONFIG="${V2RAY_CONFIG_PATH}/config.json"

StatusEcho(){
    if [[ $? -eq 0 ]]; then
        echo -e "${INFO} ${GREENBG} $1 完成 ${FONT} "
    else
        echo -e "${ERROR} ${REDBG} $1 失败 ${FONT} "
        exit 1
    fi
}

stty erase '^H' && read -p "请输入连接端口（默认：5353） => " PORT
[[ -z ${PORT} ]] && PORT="5353"

yum install wget -y
StatusEcho "安装 WGET"
yum install curl -y
StatusEcho "安装 CURL"
wget -O v2ray-installer.sh https://install.direct/go.sh
StatusEcho "获取 V2RAY 安装脚本"
bash v2ray-installer.sh --force
StatusEcho "安装 V2RAY"

UUID=$(cat /proc/sys/kernel/random/uuid)

cat > ${V2RAY_CONFIG} << EOF
{
    "inbound": {
EOF

echo -e "        \"port\": ${PORT}," >> ${V2RAY_CONFIG}

cat >> ${V2RAY_CONFIG} << EOF
        "listen": "0.0.0.0",
        "protocol": "vmess",
        "settings": {
            "clients": [
                {
EOF

echo -e "                    \"id\":\"${UUID}\"," >> ${V2RAY_CONFIG}

cat >> ${V2RAY_CONFIG} << EOF
                    "alterId": 64
                }
            ]
        },
        "streamSettings": {
            "network": "kcp",
            "kcpSettings": {
                "congestion": true,
                "header": {
                    "type": "wechat-vedio"
                }
            }
        },
        "tag": "defaultInbound"
    },
    "outbound": {
        "protocol": "freedom",
        "settings": {},
        "tag": "defaultOutbound"
    },
    "outboundDetour": [
        {
            "protocol": "blackhole",
            "settings": {
                "response": {
                    "type": "http"
                }
            },
            "tag": "shield"
        }
    ],
    "routing": {
        "strategy": "rules",
        "settings": {
            "domainStrategy": "IPIfNonMatch",
            "rules": [
                {
                    "type": "field",
                    "ip": "geoip:cn",
                    "outboundTag": "discardOutbound"
                },
                {
                    "type": "field",
                    "ip": "geoip:private",
                    "outboundTag": "discardOutbound"
                }
            ]
        }
    }
}
EOF

service v2ray restart
StatusEcho "V2RAY 加载配置"

echo -e "${INFO} ${GREENBG} V2RAY mKCP + 微信视频伪装 安装成功！${FONT} "
echo -e "${INFO} ${REDBG} 端口： ${FONT} ${PORT}"
echo -e "${INFO} ${REDBG} ID： ${FONT} ${UUID}"

rm -f v2ray-installer.sh > /dev/null 2>&1
rm -f mKCP-Wx.sh > /dev/null 2>&1