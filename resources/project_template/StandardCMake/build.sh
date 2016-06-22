cd `dirname $0`
PROJECT_ROOT=`pwd`
THIRD_PARTY_PATH=$PROJECT_ROOT/_thirdparty
BUILD_PATH=$PROJECT_ROOT/_build
BUILD_DEBUG_PATH=$BUILD_PATH/debug
BUILD_RELEASE_PATH=$BUILD_PATH/release
BUILD_THIRD_PARTY_PATH=$BUILD_PATH/thirdparty
BUILD_TEST_PATH=$BUILD_PATH/test
LIB_PATH=$PROJECT_ROOT/lib
INCLUDE_PATH=$PROJECT_ROOT/include
DEP_PATH=$PROJECT_ROOT/deps

mkdir -p $BUILD_DEBUG_PATH $BUILD_RELEASE_PATH $BUILD_THIRD_PARTY_PATH $BUILD_TEST_PATH
mkdir -p $LIB_PATH $INCLUDE_PATH
CORE_NUM=$((`nproc`-4))
if [[ $CORE_NUM -lt 4 ]]; then
    CORE_NUM=4
fi


extract_dep() {
    mkdir -p $2
    tar xzvf $1 --strip 1 -C $2
}

build_gtest() {
    path=$DEP_PATH/gtest-1.7.0.tar.gz
    if test -e $path; then
        target_path=$THIRD_PARTY_PATH/gtest
        extract_dep $path $target_path
    fi
    #path=$THIRD_PARTY_PATH/gtest-1.7.0
    #if test -d $path; then
    #    tmp_path=$BUILD_THIRD_PARTY_PATH/`basename $path`
    #    mkdir -p $tmp_path
    #    cd $tmp_path
    #    cmake $path
    #    make
    #    cp libgtest* $LIB_PATH
    #    cp -r $path/include/gtest $INCLUDE_PATH
    #    cd -
    #fi
}

build_glog() {
    path=$DEP_PATH/glog-0.3.4.tar.gz
    if test -e $path; then
        target_path=$THIRD_PARTY_PATH/glog
        extract_dep $path $target_path
        cd $target_path
        ./configure --prefix=$BUILD_THIRD_PARTY_PATH/glog
        make -j$CORE_NUM
        make install
        cd -
        cp -r $BUILD_THIRD_PARTY_PATH/glog/include/glog $INCLUDE_PATH
        cp -r $BUILD_THIRD_PARTY_PATH/glog/lib/lib* $LIB_PATH
    fi
}

build_thirdparty() {
    thirdparty_list="
        gtest 
        glog
    "
    for thirdparty in `echo $thirdparty_list`; do
        if eval "build_$thirdparty"; then
            echo "build $thirdparty success"
        fi
    done
}


build_project() {
    rm -f run
    build=$BUILD_DEBUG_PATH
    args="-DCMAKE_BUILD_TYPE=Debug"
    if [ $# = 1 ] && [ $1 = "release" ]; then
        build=$BUILD_RELEASE_PATH
        args='-DCMAKE_BUILD_TYPE=Release'
    fi

    mkdir -p $build
    cd $build
    /usr/bin/cmake $args $PROJECT_ROOT
    make -j$CORE_NUM
    cd -
    ln -s $build/run run
}

test_code() {
    $BUILD_TEST_PATH/$1
}

test_all() {
    for i in `ls $BUILD_TEST_PATH`; do
        test_code $i
    done
}

help(){
    echo "----------------------------------------------------------------------"
    echo -e "usage: ./build.sh [commands] [args]\n"
    echo "-h, help: 帮助"
    echo "debug, release, all: 构建相应版本"
    echo "-3, thirdparty [name]: 编译第三方库"
    echo "-c, clean [all]"
    echo "-t, test [all|name]: 测试"
    echo "----------------------------------------------------------------------"
}

if [[ $# == 0 ]]; then
    build_project
elif [[ $# -ge 1 ]]; then
    if [[ $1 == "help" ]] || [[ $1 == "-h" ]]; then
        help
    elif [[ $1 == "debug" ]] || [[ $1 == "release" ]]; then
        build_project $1
    elif [[ $1 == "-3" ]] || [[ $1 == "thirdparty" ]]; then
        if [[ $# -ge 2 ]]; then
            if type "build_$2" > /dev/null 2>&1; then
                eval "build_$2"
            else
                echo $2 not exists
            fi
        else
            echo "build thirdparty......"
            build_thirdparty
        fi
    elif [[ $1 == "all" ]] || [[ $1 == "-a" ]]; then
        build_thirdparty
        build_project
    elif [[ $1 == "clean" ]] || [[ $1 == "-c" ]]; then
        if [[ $# -ge 2 ]] && [[ $2 == "all" ]]; then
            rm -rf $THIRD_PARTY_PATH $INCLUDE_PATH $LIB_PATH
        fi
        rm -rf $BUILD_PATH 
        rm -f $PROJECT_ROOT/run
    elif [[ $1 == "test" ]] || [[ $1 == "-t" ]]; then
        if [[ $# -ge 2 ]] && [[ $2 != "all" ]]; then
            test_code $2
        else
            test_all
        fi
    fi
fi
