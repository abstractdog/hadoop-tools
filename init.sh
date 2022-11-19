if [ -n "$ZSH_VERSION" ]; then
   SCRIPT_DIR="${0:a:h}"
elif [ -n "$BASH_VERSION" ]; then
   SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

export PATH=$PATH:$SCRIPT_DIR/hdfs-shell/bin
export PATH=$PATH:$SCRIPT_DIR/yarn
export PATH=$PATH:$SCRIPT_DIR/hive

export ORC_UBER_JAR=$SCRIPT_DIR/orc/orc-tools-1.6.3-uber.jar

#this script is called from .bashrc, don't use echo as it can break scp
#https://bugzilla.redhat.com/show_bug.cgi?id=20527

which java > /dev/null 2>&1
if [ $? -gt 0 ]; then
    #echo -n "failed to find java, searching it under /usr..."
    export JAVA_EXEC=$(find /usr -executable -type f -name java | head -n 1)
    #echo $JAVA_EXEC
else
    export JAVA_EXEC=$(which java)
fi

if [ -z "$JAVA_HOME" ]; then
	export JAVA_HOME=$(dirname $(dirname $(readlink -f $JAVA_EXEC)))
fi

export PATH=$PATH:$JAVA_HOME/bin

source $SCRIPT_DIR/hive/hive_functions.sh
source $SCRIPT_DIR/yarn/yarn_functions.sh
source $SCRIPT_DIR/orc/orc_functions.sh
