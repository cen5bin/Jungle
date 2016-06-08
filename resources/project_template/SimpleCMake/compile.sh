rm -f run
build=`dirname $0`/build/debug
args="-DCMAKE_BUILD_TYPE=Debug"
if [ $# = 1 ] && [ $1 = "release" ]; then
    build=`dirname $0`/build/release
    args='-DCMAKE_BUILD_TYPE=Release'
fi

mkdir -p $build
cd $build
cmake $args ../..
make
cd -
ln -s $build/run run
