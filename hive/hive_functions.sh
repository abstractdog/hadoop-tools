function find_hiveserver2 () {
  for proc in $(ps aux | grep -i "org.apache.hive.service.server.HiveServer2" | grep -v grep | awk '{ print $2 }')
  do
    printf "\n*****\nhiveserver2 process: $proc\n"
    printf "open ports:\n$(netstat -tulpn | grep $proc)"
  done
  printf "\n\n"
}

function find_metastore () {
  for proc in $(ps aux | grep -i "org.apache.hadoop.hive.metastore.HiveMetaStore" | grep -v grep | awk '{ print $2 }')
  do
    printf "\n*****\nmetastore process: $proc\n"
    printf "open ports:\n$(netstat -tulpn | grep $proc)"
  done
  printf "\n\n"
}
