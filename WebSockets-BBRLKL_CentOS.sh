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

echo -e "${INFO} ${REDBG} 注意：此脚本将会为连接端口配置 BBRLKL ${FONT}"

stty erase '^H' && read -p "请输入连接端口（默认：2082） => " PORT
[[ -z ${PORT} ]] && PORT="2082"

yum install wget -y
StatusEcho "安装 wget"
yum install curl -y
StatusEcho "安装 curl"
yum install iptables -y
StatusEcho "安装 iptables"
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

[[ ! -d /home/BBRLKL ]] && mkdir -p /home/BBRLKL
wget -O /home/BBRLKL/rinetd https://raw.githubusercontent.com/hacking001/v2ray-installers/master/binaries/rinetd
StatusEcho "获取 rinetd"
chmod +x /home/BBRLKL/rinetd
echo "0.0.0.0 ${PORT} 0.0.0.0 ${PORT}" >> /home/BBRLKL/ports.conf
IFACE=`ip -4 addr | awk '{if ($1 ~ /inet/ && $NF ~ /^[ve]/) {a=$NF}} END{print a}'`
echo -e "#!/bin/bash\ncd /home/BBRLKL\nnohup ./rinetd -f -c ports.conf raw ${IFACE} &" > /home/BBRLKL/start.sh
chmod +x /home/BBRLKL/start.sh
echo -e "#!/bin/bash\n" > /etc/rc.local
echo "/bin/bash /home/BBRLKL/start.sh" >> /etc/rc.local
chmod +x /etc/rc.local
/bin/bash /home/BBRLKL/start.sh
echo -e "${INFO} BBRLKL 配置完成"

clear
echo -e "${INFO} ${GREENBG} v2ray WebSockets 安装成功！${FONT} "
echo -e "${INFO} ${REDBG} 端口： ${FONT} ${PORT}"
echo -e "${INFO} ${REDBG} ID： ${FONT} ${UUID}"
echo -e "${INFO} ${REGBG} alterId： ${FONT} 0"

rm -f v2ray-installer.sh > /dev/null 2>&1
rm -f WebSockets-BBRLKL.sh > /dev/null 2>&1