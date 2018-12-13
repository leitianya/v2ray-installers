#!/usr/bin/env python
# -*- coding: utf-8 -*-
defaultConf = {
	'routing': {
		'strategy': 'rules',
		'settings': {
			'domainStrategy': 'IPIfNonMatch',
			'rules': [
				{
					'type': 'field',
					'ip': 'geoip:cn',
					'outboundTag': 'blockOutbound'
				},
				{
					'type': 'field',
					'ip': 'geosite:cn',
					'outboundTag': 'blockOutbound'
				}
			]
		}
	},
	'inbounds': [
		{
			'listen': '0.0.0.0',
			'port': 80,
			'protocol': 'vmess',
			'settings': {
				'clients': [
					{
						'id': '',
						'alterId': 0
					}
				]
			},
			'streamSettings': {
				'network': 'tcp'
			},
			'tag': 'defaultInbound'
		}
	],
	'outbounds': [
		{
			'protocol': 'freedom',
			'settings': {},
			'tag': 'defaultOutbound'
		},
		{
			'protocol': 'blackhole',
			'settings': {
				'response': {
					'type': 'http'
				}
			},
			'tag': 'blockOutbound'
		}
	]
}

def execute(text):
	import os

	try:
		code = os.system(text)
		if code != 0:
			return 0
		else:
			return 1
	except Exception as e:
		try:
			open('error.txt', 'w').write(str(e))
		except:
			pass

		return 0

def main():
	import json, uuid

	try:
		input = raw_input
	except:
		pass
	
	print('1. TCP 2. WebSockets 3. mKCP')
	print('请选择传输模式（输入序列号） => ', end = '')
	CFG_MODE = input()
	if CFG_MODE == 1:
		print('您已选择 TCP 传输模式 ...')
		defaultConf['inbounds'][0]['streamSettings']['network'] = 'tcp'
	elif CFG_MODE == 2:
		print('您已选择 WebSockets 传输模式 ...')
		defaultConf['inbounds'][0]['streamSettings']['network'] = 'ws'
	elif CFG_MODE == 3:
		print('您已选择 mKCP 传输模式 ...')
		defaultConf['inbounds'][0]['streamSettings']['network'] = 'mkcp'
	else:
		print('选择有误 ...')
		return
	
	print('Cloudflare 支持的端口列表：')
	print('HTTP 协议：80、8080、8880、2052、2082、2086、2095')
	print('HTTPS 协议：443、2053、2083、2087、2096、8443')
	print('在专业套餐及更高版本上，可以使用 WAF 规则 ID 100015 阻止除 80 和 443 之外的所有端口的请求')
	print('80 和 443 端口是 Cloudflare Apps 能够使用的唯一端口')
	print('80 和 443 端口是 Cloudflare Cache 能够使用的唯一端口')
	print('请输入端口号（默认 2082） => ', end = '')
	CFG_PORT = input()
	if CFG_PORT == '':
		CFG_PORT = 2082
		return
	else:
		try:
			CFG_PORT = int(CFG_PORT)
		except ValueError:
			print('输入错误 ...')
		else:
			defaultConf['inbounds'][0]['port'] = CFG_PORT
	
	print('正在生成用户连接 ID 中 ...', end = ' ')
	defaultConf['inbounds'][0]['settings']['clients'][0]['id'] = str(uuid.uuid4())
	print('完成 ...')

	print('正在更新软件源中 ...', end = ' ')
	if execute('apt update'):
		print('完成 ...')
	else:
		print('失败 ...')
		return
	
	print('正在安装依赖软件中 ...', end = ' ')
	if execute('apt install wget curl -y'):
		print('完成 ...')
	else:
		print('失败 ...')
		return
	
	print('正在下载核心程序中 ...', end = ' ')
	if execute('wget -O v2ray-installer.sh https://install.direct/go.sh'):
		print('成功，安装中 ...', end = ' ')

		if execute('chmod +x v2ray-installer.sh') and execute('./v2ray-installer.sh --force'):
			print('成功 ...')
		else:
			print('失败 ...')
			return
	else:
		print('失败 ...')
		return
	
	print('正在写入配置文件中 ...', end = ' ')
	try:
		open('/etc/v2ray/config.json', 'w').write(json.dumps(defaultConf))
	except Exception as e:
		try:
			open('error.log', 'w').write(str(e))
		except:
			pass

		print('失败 ...')
		return
	
	print('正在重启服务中 ...', end = ' ')
	if execute('systemctl restart v2ray'):
		print('成功 ...')
	else:
		print('失败 ...')
	
	print('ID：%s' % defaultConf['inbounds'][0]['settings']['clients'][0]['id'])
	print('alterId：%i' % defaultConf['inbounds'][0]['settings']['clients'][0]['alterId'])
	print('连接端口：%i' % defaultConf['inbounds'][0]['port'])
	print('传输协议：%s' % defaultConf['inbounds'][0]['streamSettings']['network'])

if __name__ == '__main__':
	main()