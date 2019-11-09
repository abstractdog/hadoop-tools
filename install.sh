#!/bin/bash
git --version > /dev/null
[[ $? == 0 ]] && { echo "git is installed"; } || { echo "git is not installed, exiting..."; exit 1;}

git clone https://github.com/abstractdog/hadoop-tools
cd hadoop-tools
./init.sh

if [[ -f ~/.bashrc ]]; then
    echo "source $PWD/init.sh" >> ~/.bashrc
    echo "hadoop-tools initializer script is written into .bashrc"
else
    echo "~/.bashrc is not found, you have to include \"source $PWD/init.sh\" somewhere else"
fi