if [ $# != 3 ]; then
    echo 参数数量错误
    exit
fi

if test ! -d $2; then
    echo $2 目录不存在
    exit
fi

source=$1
target=$2/$3



cp -r $source $target
cd $target

sed "s/__module_name__/$3/g" CMakeLists.txt > tmp
mv tmp CMakeLists.txt

