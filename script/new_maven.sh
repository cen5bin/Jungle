if [ $# != 3 ]; then
    echo 参数数量错误
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
