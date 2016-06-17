if [ $# != 1 ]; then
    echo 参数数量错误
    exit
fi
cd $1
tar xzvf vim.tar.gz
mv vimrc ~/.vimrc
rm -rf ~/.vim
mv vim ~/.vim
