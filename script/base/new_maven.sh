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

sed  "s/SimpleMaven/$3/g"  pom.xml > pom
mv pom pom.xml

sed  "s/SimpleMaven/$3/g"  run.sh > run
mv run run.sh
chmod +x run.sh
