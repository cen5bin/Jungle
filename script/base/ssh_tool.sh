if [ $# == 0 ]; then
    echo usage: ./ssh_tool.sh cmd
    echo cmd:
    echo "[1]. quick login"
    exit
fi


if [ $1 == '1' ]; then
    # 免密登录配置
    if [ $# != 3 ]; then
        echo usage: ./ssh_tool.sh 1 username@ip password
        exit
    fi
    expect -c "
        spawn ssh-copy-id $2
        expect *password* { 
            send $3\r 
        } *yes/no* { 
            send yes\r 
            expect *password* {
                send $3\r
            }
        }
        expect eof
    "
elif [ $1 == '2' ]; then
    echo "aa"
fi
