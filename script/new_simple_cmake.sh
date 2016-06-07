if [ $# != 3 ]; then
    echo 参数数量错误
    exit
fi

source=$1
target=$2/$3

cp -r $source $target
cd $target

mkdir -p Build/Debug
mkdir -p Build/Release
