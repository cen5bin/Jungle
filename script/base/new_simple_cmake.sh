if [ $# != 3 ]; then
    echo 参数数量错误
    exit
fi

source=$1
target=$2/$3


cp -r $source $target
cd $target

sed "s/PROJECT_NAME/$3/g" CMakeLists.txt > tmp
mv tmp CMakeLists.txt

mkdir -p include
mkdir -p lib
