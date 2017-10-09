#!/bin/sh
#
# Copyright (c) 2016-2020 Chen Kline
#

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

echo Using CGW_MQTT_HOME:   "$CGW_MQTT_HOME"

cd "$CGW_MQTT_HOME"
rm -rf log logs mapdb *.log

REDIS_BIN=/opt/redis/redis3/src
$REDIS_BIN/redis-cli -h 127.0.0.1 -p 6379 flushall
