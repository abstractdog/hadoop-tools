
function yarn_poll_app_logs () {
  APP=$1
  AS_USER=$2

  echo "polling application logs: $APP"
  success=1
  counter=0
  while [ $success -gt 0 ]
  do
    counter=$(( $counter + 1 ))
    #clear
    echo "...fetching app logs, attempt: $counter..."
    if [ -z "$AS_USER" ]; then
      yarn logs -applicationId $APP --size_limit_mb -1 > /dev/null
    else
      sudo -u $AS_USER yarn logs -applicationId $APP --size_limit_mb -1 > /dev/null
    fi
    success=$?
  done

  echo "saving application logs to $APP.log"
  if [ -z "$AS_USER" ]; then
    yarn logs -applicationId $APP --size_limit_mb -1 > $APP.log
  else
    sudo -u $AS_USER yarn logs -applicationId $APP --size_limit_mb -1 > $APP.log
  fi

  less $APP.log
}

function yarn_app_container_list(){
  APP=$1
  yarn logs -applicationId $APP -show_application_log_info
}

function yarn_list_hive_applications(){
  yarn application -list | awk '$2 ~ "HIVE" { print $1,$2 }'
}

function yarn_kill_hive_applications(){
	yarn_list_hive_applications

	read -p "Are you sure to kill all hive/tez yarn applications (AMs) [y/n]? " -n 1 -r
	echo    # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		yarn application -list | awk '$2 ~ "HIVE" { print $1 }' | xargs -I {} yarn application -kill {}
	fi
}

function yarn_list_llap_applications(){
  yarn application -list | awk '$2 ~ "llap" { print $1,$2 }'
}

function yarn_kill_llap_applications(){
	yarn_list_llap_applications

	read -p "Are you sure to kill all llap yarn applications (daemons) [y/n]? " -n 1 -r
	echo    # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		yarn application -list | awk '$2 ~ "llap" { print $1 }' | xargs -I {} yarn application -kill {}
	fi
}
