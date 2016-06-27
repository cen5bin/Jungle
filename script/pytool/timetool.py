#!/usr/bin/python
#coding=utf-8

import time, datetime, sys

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

def ts_to_str():
    ts = float(input_data('输入时间戳: '))
    dt = datetime.datetime.fromtimestamp(ts)
    print '实际时间: %s' % dt.strftime('%Y-%m-%d %H:%M:%S')

cmd_list = [
    ('timestamp to date string', ts_to_str)        
]

def show_list():
    print '%s%s%s' % ('-' * 20, '时间换算工具', '-' * 20)
    for i in range(0, len(cmd_list)):
        print '  [%d] %s' % (i + 1, cmd_list[i][0])

    print '\n%s' % ('-' * 50 )
    print '请输入命令前的编号: '


if __name__ == '__main__':
    try:
        while True:
            show_list()
            cmd = input_data()
            if int(cmd) > len(cmd_list) or int(cmd) == 0:
                print 'Bye!'
                break
            print cmd_list[int(cmd)-1][0]
            while True:
                cmd_list[int(cmd)-1][1]() 
                x = input_data('continue?[Y/n]')
                if x == 'n':
                    break
    except KeyboardInterrupt:
        bye()
        exit()
    except Exception, ex:
        bye()
