#!/bin/sh
#
# Copyright (c) 2012-2015 Andrea Selva
#

echo "                                                                         "
echo "  ___  ___                       _   _        ___  ________ _____ _____  "
echo "  |  \/  |                      | | | |       |  \/  |  _  |_   _|_   _| "
echo "  | .  . | ___   __ _ _   _  ___| |_| |_ ___  | .  . | | | | | |   | |   "
echo "  | |\/| |/ _ \ / _\ | | | |/ _ \ __| __/ _ \ | |\/| | | | | | |   | |   "
echo "  | |  | | (_) | (_| | |_| |  __/ |_| ||  __/ | |  | \ \/' / | |   | |   "
echo "  \_|  |_/\___/ \__, |\__,_|\___|\__|\__\___| \_|  |_/\_/\_\ \_/   \_/   "
echo "                   | |                                                   "
echo "                   |_|                                                   "
echo "                                                                         "                                                                      

# get directory of this file 
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  TARGET="$(readlink "$SOURCE")"
  if [[ $TARGET == /* ]]; then
    echo "SOURCE '$SOURCE' is an absolute symlink to '$TARGET'"
    SOURCE="$TARGET"
  else
    DIR="$( dirname "$SOURCE" )"
    echo "SOURCE '$SOURCE' is a relative symlink to '$TARGET' (relative to '$DIR')"
    SOURCE="$DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  fi
done
#echo "SOURCE is '$SOURCE'"
PRG_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# get 
CGW_MQTT_HOME="$( cd "$PRG_DIR/.." && pwd )"
export CGW_MQTT_HOME

# Only set MOQUETTE_HOME if not already set
[ -f "$MOQUETTE_HOME"/bin/moquette.sh ] || MOQUETTE_HOME=$CGW_MQTT_HOME
export MOQUETTE_HOME

# Set JavaHome if it exists
if [ -f "${JAVA_HOME}/bin/java" ]; then 
   JAVA=${JAVA_HOME}/bin/java
else
   JAVA=java
fi
export JAVA

echo Using JAVA_HOME:       "$JAVA_HOME"
echo Using CGW_MQTT_HOME:   "$CGW_MQTT_HOME"
echo Using MOQUETTE_HOME:   "$MOQUETTE_HOME"

mkdir -p "$CGW_MQTT_HOME/logs"
mkdir -p "$CGW_MQTT_HOME/log"
mkdir -p "$CGW_MQTT_HOME/mapdb"
cd "$CGW_MQTT_HOME"

LOG_FILE=$MOQUETTE_HOME/config/cgw-mqtt-log.properties
MOQUETTE_PATH=$MOQUETTE_HOME/
#LOG_CONSOLE_LEVEL=info
#LOG_FILE_LEVEL=fine
JAVA_OPTS_SCRIPT="-XX:+HeapDumpOnOutOfMemoryError -Djava.awt.headless=true"

#$JAVA -server -Dspring.config.location="file:$CGW_MQTT_HOME/config/application.yml" $JAVA_OPTS $JAVA_OPTS_SCRIPT -Dlog4j.configuration="file:$LOG_FILE" -Dmoquette.path="$MOQUETTE_PATH" -cp "$MOQUETTE_HOME/lib/*" com.huahan.ipms.cgw.apps.mqtt.MqttApp
nohup $JAVA -server -Dspring.config.location="file:$CGW_MQTT_HOME/config/application.yml" $JAVA_OPTS $JAVA_OPTS_SCRIPT -Dlog4j.configuration="file:$LOG_FILE" -Dmoquette.path="$MOQUETTE_PATH" -cp "$MOQUETTE_HOME/lib/*" com.huahan.ipms.cgw.apps.mqtt.MqttApp >> $CGW_MQTT_HOME/log/cgw-log.txt &
