# v2ray 一键安装脚本 支持多种模式
[GitHub](https://github.com/hacking001/v2ray-installers)、[GitLab](https://gitlab.com/hacking001/v2ray-installers)、[Coding](https://dev.tencent.com/u/hacking001/p/v2ray-installers)

推一下自己的项目：[v2tap - 将 tun2socks 和 v2ray 搭配实现的 VPN 工具，跟 SSTap 类似](https://github.com/hacking001/v2tap)

## 总览
- [已通过测试的系统](#已通过测试的系统)
- [注意事项](#注意事项)
- [常用命令](#常用命令)
- [安装](#安装)
    - [All in One](#all-in-one)
    - [mKCP + WebSockets for Debian、Ubuntu](#mkcp--websockets-for-debainubuntu)
    - [mKCP + WebSockets for CentOS](#mkcp--websockets-for-centos)
    - [WebSockets for Debian、Ubuntu](#websockets-for-debianubuntu)
    - [WebSockets for CentOS](#websockets-for-centos)
    - [mKCP for Debian、Ubuntu](#mkcp-for-debianubuntu)
    - [mKCP for CentOS](#mkcp-for-centos)
- [安装 mKCP 的伪装版本](#安装-mkcp-的伪装版本)
    - [mKCP for Debian、Ubuntu with wechat-vedio mask](#mkcp-for-debianubuntu-with-wechat-vedio-mask)
    - [mKCP for CentOS with wechat-vedio mask](#mkcp-for-centos-with-wechat-vedio-mask)
    - [mKCP for Debian、Ubuntu with DTLS mask](#mkcp-for-debianubuntu-with-dtls-mask)
    - [mKCP for CentOS with DTLS mask](#mkcp-for-centos-with-dtls-mask)
    - [mKCP for Debian、Ubuntu with WireGuard mask](#mkcp-for-debianubuntu-with-wireguard-mask)
    - [mKCP for CentOS with WireGuard mask](#mkcp-for-centos-with-wireguard-mask)
- [安装附带 BBRLKL 的版本](#安装附带-bbrlkl-的版本)
    - [WebSockets for OpenVZ Debian、Ubuntu with BBRLKL](#websockets-for-openvz-debianubuntu-with-bbrlkl)
    - [WebSockets for OpenVZ CentOS](#websockets-for-openvz-centos-with-bbrlkl)
- [内核更新](#内核更新)
- [更新日志](#更新日志)

## 已通过测试的系统
- Ubuntu 18.04
- Ubuntu 16.04
- CentOS 7

理论上 v2ray 官方脚本能成功安装的系统，这里的都能安装成功

## 注意事项
- 请在干净的系统下安装
- v2ray 依赖系统时间，请确保系统 UTC 时间误差在三分钟以内，时区无关
- 与 Cloudflare 搭配的话请不要随便修改您的域名在 Cloudflare 上的设置（如果您不懂的话）
- WebSockets 模式支持 Cloudflare 前置，默认端口安装即可（懂的请随意）
- 如果 WebSockets 模式需要搭配 Cloudflare + SSL，可以将 v2ray 安装于 80 端口，并且在 Cloudflare 的加密板块中将模式调成 `Flexible`（在客户端连接时使用 443 端口并配置 SSL 安全就行）

## 常用命令
检查 v2ray 状态
```bash
service v2ray status
```
启动 v2ray 服务
```bash
service v2ray start
```
关闭 v2ray 服务
```bash
service v2ray stop
```
重启 v2ray 服务
```bash
service v2ray restart
```

## 安装
### All in One
*警告：这是测试功能，并不保证可以运行*
*已在 Ubuntu 16.04 + Python 3 环境下测试通过*
```bash
wget -O v2ray-installers.py https://raw.githubusercontent.com/hacking001/v2ray-installers/master/v2ray-installers.py && python3 v2ray-installers.py
```
### mKCP + WebSockets for Debain、Ubuntu
```bash
wget -O mKCP-WebSockets.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/mKCP-WebSockets.sh && bash mKCP-WebSockets.sh
```
### mKCP + WebSockets for CentOS
```bash
wget -O mKCP-WebSockets.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/mKCP-WebSockets_CentOS.sh && bash mKCP-WebSockets.sh
```
### WebSockets for Debian、Ubuntu
```bash
wget -O WebSockets.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/WebSockets.sh && bash WebSockets.sh
```
### WebSockets for CentOS
```bash
wget -O WebSockets.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/WebSockets_CentOS.sh && bash WebSockets.sh
```
### mKCP for Debian、Ubuntu
```bash
wget -O mKCP.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/mKCP.sh && bash mKCP.sh
```
### mKCP for CentOS
```bash
wget -O mKCP.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/mKCP_CentOS.sh && bash mKCP.sh
```

## 安装 mKCP 的伪装版本
### mKCP for Debian、Ubuntu with wechat-vedio mask
```bash
wget -O mKCP-Wx.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/mKCP-Wx.sh && bash mKCP-Wx.sh
```
### mKCP for CentOS with wechat-vedio mask
```bash
wget -O mKCP-Wx.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/mKCP-WeChatVedio_CentOS.sh && mKCP-Wx.sh
```
### mKCP for Debian、Ubuntu with DTLS mask
```bash
wget -O mKCP-DTLS.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/mKCP-DTLS.sh && bash mKCP-DTLS.sh
```
### mKCP for CentOS with DTLS mask
```bash
wget -O mKCP-DTLS.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/mKCP-DTLS_CentOS.sh && mKCP-DTLS.sh
```
### mKCP for Debian、Ubuntu with WireGuard mask
```bash
wget -O mKCP-WireGuard.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/mKCP-WireGuard.sh && bash mKCP-WireGuard.sh
```
### mKCP for CentOS with WireGuard mask
```bash
wget -O mKCP-WireGuard.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/mKCP-WireGuard_CentOS.sh && bash mKCP-WireGuard.sh
```

## 安装附带 BBRLKL 的版本
### WebSockets for OpenVZ Debian、Ubuntu with BBRLKL
```bash
wget -O WebSockets-BBRLKL.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/WebSockets-BBRLKL.sh && bash WebSockets-BBRLKL.sh
```
### WebSockets for OpenVZ CentOS with BBRLKL
```bash
wget -O WebSockets-BBRLKL.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/WebSockets-BBRLKL_CentOS.sh && bash WebSockets-BBRLKL.sh
```

## 内核更新
```bash
wget -O v2ray-installer.sh https://install.direct/go.sh && bash v2ray-installer.sh && rm -f v2ray-installer.sh
```
来源：[下载安装 · Project V 官方网站](https://www.v2ray.com/chapter_00/install.html)

## 更新日志
参见 commits 日志