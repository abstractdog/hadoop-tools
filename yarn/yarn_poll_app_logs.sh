APP=$1

echo "polling application logs: $APP"
success=1
counter=0
while [ $success -gt 0 ]
do
  counter=$(( $counter + 1 ))
  #clear
  echo "...fetching app logs, attempt: $counter..."
  yarn logs -applicationId $APP > /dev/null
  success=$?
done
echo "saving application logs to $APP.log"
yarn logs -applicationId $APP > $APP.log
