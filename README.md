# v2ray 一键安装脚本 支持多种模式
*有问题请发 [issue](https://github.com/hacking001/v2ray-installers/issues)*

## 总览
总览并非实时更新，需要自行到底下查看
- [已通过测试的系统](#已通过测试的系统)
- [注意事项](#注意事项)
- [常用命令](#常用命令)
- [准备工作](#准备工作)
- [安装](#安装)
    - [WebSockets for Debian、Ubuntu](#websockets-for-debianubuntu)
    - [WebSockets for CentOS](#websockets-for-centos)
    - [HTTP2 for Debian、Ubuntu](#http2-for-debianubuntu未经过测试)
    - [HTTP2 for CentOS](#http2-for-centos)
- [安装附带 BBRLKL 的版本](#安装附带-bbrlkl-的版本)
    - [WebSockets for OpenVZ Debian、Ubuntu with BBRLKL](#websockets-for-openvz-debianubuntu-with-bbrlkl未经过测试)
    - [WebSockets for OpenVZ CentOS with BBRLKL](#websockets-for-openvz-centos-with-bbrlkl未经过测试)
- [内核更新](#内核更新)
- [更新日志](#更新日志)
    - [2018 年 8 月 6 日](#2018-年-8-月-6-日)

## 已通过测试的系统
- Ubuntu 16.04
- CentOS 7

## 注意事项
- 不推荐 CentOS，因为可能需要自行放行端口
- 请在干净的系统下安装
- v2ray 依赖系统时间，请确保系统 UTC 时间误差在三分钟以内，时区无关
- 脚本配置出来的 v2ray 默认屏蔽中国 IP、服务器内网段，这是为了安全
- 与 Cloudflare 搭配的话请不要随便修改您的域名在 Cloudflare 上的设置（如果您不懂的话）
- WebSockets 模式支持 Cloudflare 前置，默认端口安装即可（懂的请随意）

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

## 准备工作
- 如果使用 HTTP2 模式，请准备一个域名，并设置 A 记录到服务器上

## 安装
### WebSockets for Debian、Ubuntu
```bash
wget -O WebSockets.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/WebSockets.sh && bash WebSockets.sh
```

### WebSockets for CentOS
```bash
wget -O WebSockets.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/WebSockets-CentOS.sh && bash WebSockets.sh
```

###  HTTP2 for Debian、Ubuntu（未经过测试）
```bash
wget -O HTTP2.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/HTTP2.sh && bash HTTP2.sh
```

### HTTP2 for CentOS（未经过测试）
```bash
wget -O HTTP2.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/HTTP2-CentOS.sh && bash HTTP2.sh
```
### mKCP for Debian、Ubuntu
```
wget -O mKCP.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/mKCP.sh && bash mKCP.sh
```
### mKCP for CentOS
```bash
wget -O mKCP.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/mKCP-CentOS.sh && bash mKCP.sh
```
### mKCP for Debian、Ubuntu with wechat-vedio mask
```bash
wget -O mKCP.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/mKCP-WeChatVedio.sh && bash mKCP.sh
```
### mKCP for CentOS with wechat-vedio mask
```bash
wget -O mKCP.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/mKCP-WeChatVedio-CentOS.sh && bash mKCP.sh
```

## 安装附带 BBRLKL 的版本
### WebSockets for OpenVZ Debian、Ubuntu with BBRLKL（未经过测试）
```bash
wget -O WebSockets.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/WebSockets-BBRLKL.sh && bash WebSockets.sh
```
### WebSockets for OpenVZ CentOS with BBRLKL（未经过测试）
```bash
wget -O WebSockets.sh https://raw.githubusercontent.com/hacking001/v2ray-installers/master/WebSockets-BBRLKL-CentOS.sh && bash WebSockets.sh
```

## 内核更新
```bash
wget -O v2ray-installer.sh https://install.direct/go.sh && bash v2ray-installer.sh && rm -f v2ray-installer.sh
```
来源：[下载安装 · Project V 官方网站](https://www.v2ray.com/chapter_00/install.html)

## 更新日志
### 2018 年 8 月 6 日
- 项目初始化