# v2ray 一键安装脚本 支持多种模式
*有问题请发 [issue](https://github.com/hacking001/v2ray-installers/issues)*

## 已通过测试的系统
- Ubuntu 16.04
- CentOS 7

## 注意事项
- 不推荐 CentOS，因为可能需要自行放行端口
- 请在干净的系统下安装
- v2ray 依赖系统时间，请确保系统 UTC 时间误差在三分钟以内，时区无关
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
### 2018 年 8 月 6 日
- 项目初始化