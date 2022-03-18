CONTAINER=$1 # mandatory
FILTER=$2	 # optional


if [ -z "$CONTAINER" ]; then
	echo "Container id is empty, let's list available applications:"
	yarn application -list -appStates RUNNING
	exit 0
fi


if [[ $CONTAINER == application* ]]; then
	echo "Application id detected (instead of container), checking container info for app: $CONTAINER"
	yarn logs -applicationId $CONTAINER -show_application_log_info
	exit 0
fi

echo "Following(tailing) tez container: $CONTAINER"

HOST=`yarn container -status $CONTAINER | grep "Host" | cut -d ":" -f 2`

echo -e "\nContainer is running on host: $HOST"

COMMAND=`ssh $HOST "ps aux | grep $CONTAINER | grep -v bash | grep java"`

echo -e "\nContainer ps: $COMMAND"

CONTAINER_LOG_DIR=`echo $COMMAND | awk -F "yarn.app.container.log.dir=" '{print $2;}' | awk -F " " '{print $1;}'`

echo -e "\nContainer log dir: $CONTAINER_LOG_DIR"

ssh $HOST "ls -la $CONTAINER_LOG_DIR"

LATEST_FILE=`ssh $HOST "ls -1 --time=access $CONTAINER_LOG_DIR | head -n 1"`

echo -e "\nWill follow container file: $LATEST_FILE"

echo -e "Command to check full file: *** \n\nssh -t $HOST less $CONTAINER_LOG_DIR/$LATEST_FILE\n\n***"

if [ -z "$FILTER" ]; then
	ssh $HOST "tail -f $CONTAINER_LOG_DIR/$LATEST_FILE"
else
	echo "Tailing file with filter: '$FILTER'"
	ssh $HOST "tail -f $CONTAINER_LOG_DIR/$LATEST_FILE | grep '$FILTER'"
fi
