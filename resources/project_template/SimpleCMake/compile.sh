rm -f run
build=`dirname $0`/Build/Debug
args="-DCMAKE_BUILD_TYPE=Debug"
if [ $# = 1 ] && [ $1 = "release" ]; then
    build=`dirname $0`/Build/Release
    args='-DCMAKE_BUILD_TYPE=Release'
fi

cd $build
cmake $args ../..
make
cd -
ln -s $build/run run
