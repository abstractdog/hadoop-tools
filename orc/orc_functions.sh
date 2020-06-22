
#http://www.mtitek.com/tutorials/bigdata/hadoop/orc-tools.php
function orc_filedump () {
  FILE=$1
  if [[ -z $FILE ]]; then
    echo "please provide an orc file as first parameter"
    #$JAVA_EXEC -jar $ORC_UBER_JAR --help
  else
    $JAVA_EXEC -jar $ORC_UBER_JAR meta $FILE
    $JAVA_EXEC -jar $ORC_UBER_JAR data $FILE
  fi
}