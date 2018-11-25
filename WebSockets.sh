#!/usr/bin/env bash

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

echo -e "${INFO} Cloudflare 支持的端口列表："
echo -e "${INFO} HTTP 协议：80、8080、8880、2052、2082、2086、2095"
echo -e "${INFO} HTTPS 协议：443、2053、2083、2087、2096、8443"
echo -e "${INFO} 在专业套餐及更高版本上，可以使用 WAF 规则 ID 100015 阻止除 80 和 443 之外的所有端口的请求"
echo -e "${INFO} 80 和 443 端口是 Cloudflare Apps 能够使用的唯一端口"
echo -e "${INFO} 80 和 443 端口是 Cloudflare Cache 能够使用的唯一端口"

stty erase '^H' && read -p "请输入连接端口（默认：2082） => " PORT
[[ -z ${PORT} ]] && PORT="2082"

apt update
StatusEcho "更新 apt"
apt install wget -y
StatusEcho "安装 wget"
apt install curl -y
StatusEcho "安装 curl"
wget -O v2ray-installer.sh https://install.direct/go.sh
StatusEcho "获取 v2ray 安装脚本"
chmod +x v2ray-installer.sh
./v2ray-installer.sh --force
StatusEcho "安装 v2ray"

UUID=$(cat /proc/sys/kernel/random/uuid)

cat > ${V2RAY_CONFIG} << EOF
{
    "routing": {
        "strategy": "rules",
        "settings": {
            "domainStrategy": "IPIfNonMatch",
            "rules": [
                {
                    "type": "field",
                    "ip": "geoip:cn",
                    "outboundTag": "blockOutbound"
                },
                {
                    "type": "field",
                    "ip": "geoip:private",
                    "outboundTag": "blockOutbound"
                }
            ]
        }
    },
    "inbounds": [
        {
            "listen": "0.0.0.0",
EOF

echo -e "            \"port\": ${PORT}," >> ${V2RAY_CONFIG}

cat >> ${V2RAY_CONFIG} << EOF
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
EOF

echo -e "                        \"id\":\"${UUID}\"," >> ${V2RAY_CONFIG}

cat >> ${V2RAY_CONFIG} << EOF
                        "alterId": 0
                    }
                ]
            },
            "streamSettings": {
                "network": "ws"
            },
            "tag": "defaultInbound"
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "settings": {},
            "tag": "defaultOutbound"
        },
        {
            "protocol": "blackhole",
            "settings": {
                "response": {
                    "type": "http"
                }
            },
            "tag": "blockOutbound"
        }
    ]
}
EOF

service v2ray restart
StatusEcho "v2ray 加载配置"

clear
echo -e "${INFO} ${GREENBG} v2ray WebSockets 安装成功！${FONT} "
echo -e "${INFO} ${REDBG} 端口： ${FONT} ${PORT}"
echo -e "${INFO} ${REDBG} ID： ${FONT} ${UUID}"
echo -e "${INFO} ${REGBG} alterId： ${FONT} 0"

rm -f v2ray-installer.sh > /dev/null 2>&1
rm -f WebSockets.sh > /dev/null 2>&1