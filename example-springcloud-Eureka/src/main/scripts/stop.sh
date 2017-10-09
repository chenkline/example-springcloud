#!/bin/sh
#
# Copyright (c) 2016-2020 Chen Kline
#

ps -ef |grep "com.huahan.ipms.cgw.apps.mqtt" |awk '{print $2}'|xargs kill -9

