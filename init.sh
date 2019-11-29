SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PATH=$PATH:$SCRIPT_DIR/hdfs-shell/bin
export PATH=$PATH:$SCRIPT_DIR/yarn

which java > /dev/null 2>&1
if [ $? -gt 0 ]; then
    echo -n "failed to find java, searching it under /usr..."
    export JAVA_EXEC=$(find /usr -executable -type f -name java | head -n 1)
    echo $JAVA_EXEC
else
    export JAVA_EXEC=$(which java)
fi

