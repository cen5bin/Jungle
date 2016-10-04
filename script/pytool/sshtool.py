#!/usr/bin/python
#coding=utf-8
from module import path, conf
import time, datetime, sys, os

def bye():
    sys.stdout.write('\b\b\bBye!\n')
    sys.stdout.flush()

def input_data(str=''):
    try:
        ret = raw_input(str)
        return ret
    except KeyboardInterrupt:
        bye()
        exit()

def free_login():
    print '免密码登录配置：'
    print '参数 [ip] [password]'
    print '合法的ip格式：'
    print '1.2.3.4'
    print '1.2.3.4-10'
    print '1.2.3.4,2.3.4.5'
    print conf.baseRoot
    input_str = input_data()
    data = input_str.split(' ')[0]
    password = input_str.split(' ')[1]
    ip_list = []
    if ',' in data:
        ip_list = data.split(',')
    elif '-' in data:
        tmp = data.split('-')
        x = int(tmp[0].split('.')[3])
        prefix = '.'.join(tmp[0].split('.')[:3])
        print prefix
        for i in range(x, int(tmp[1]) + 1):
            ip_list.append(prefix + '.' + str(i))
    else:
        ip_list.append(data)

    for ip in ip_list:
        shell = "sh %s 1 %s %s" % (os.path.join(conf.baseRoot, 'ssh_tool.sh'), ip, password)
        os.system(shell)
        #print shell

cmd_list = [
    ('免密登录', free_login),        
]


def show_list():
    print '%s%s%s' % ('-' * 20, 'ssh工具', '-' * 20)
    for i in range(0, len(cmd_list)):
        print ' [%d] %s' % (i + 1, cmd_list[i][0])
    print '\n%s' % ('-' * 50)
    print '请输入命令前的编号: '

if __name__ == '__main__':
    print os.path.realpath(__file__)
    try:
        while True:
            show_list()
            cmd = input_data()
            if int(cmd) > len(cmd_list) or int(cmd) == 0:
                print 'Bye!'
                break
            cmd_list[int(cmd)-1][1]()
    except KeyboardInterrupt:
        bye()
        exit()

    except Exception, ex:
        bye()
