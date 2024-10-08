#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PAIMON_UI_HOME="${PAIMON_UI_HOME:-$(pwd)}"
source ${PAIMON_UI_HOME}/bin/env.sh



function print_usage {
    echo "Usage: $0 [--daemon] [--help|-h]"
    echo ""
    echo "Options:"
    echo "  --daemon  Run Paimon Web Server as a background process."
    echo "  --help|-h Show this help message and exit."
}

DAEMON=false
while [[ $# -gt 0 ]]; do
  case "$1" in
    --daemon)
      DAEMON=true
      ;;
    --help|-h)
      print_usage
      exit 0
      ;;
    *)
      echo "Unsupported parameter: $1"
      exit 1
      ;;
  esac
  shift
done

if [[ "$DOCKER" == "true" ]]; then
  JAVA_OPTS="${JAVA_OPTS} -XX:-UseContainerSupport"
fi

echo "JAVA_HOME=${JAVA_HOME}"
echo "JAVA_OPTS=${JAVA_OPTS}"
echo "PAIMON_UI_HOME=${PAIMON_UI_HOME}"
echo "FLINK_HOME=${FLINK_HOME}"
echo "ACTION_JAR_PATH=${ACTION_JAR_PATH}"

if [ -z "$PAIMON_UI_HOME" ]; then
    echo "PAIMON_UI_HOME is null, exit..."
    exit 1
fi
if [ -z "$JAVA_HOME" ]; then
      echo "JAVA_HOME is null, exit..."
      exit 1
else
   export JAVA_HOME=$JAVA_HOME
fi
if [ -z "$FLINK_HOME" ]; then
    echo "FLINK_HOME is null, CDC cannot be used normally!"
else
    export FLINK_HOME=$FLINK_HOME
fi
if [ -z "$ACTION_JAR_PATH" ]; then
    echo "ACTION_JAR_PATH is null, CDC cannot be used normally!"
else
    export ACTION_JAR_PATH=$ACTION_JAR_PATH
fi


if [ "$DAEMON" = true ]; then
  nohup $JAVA_HOME/bin/java $JAVA_OPTS \
    -cp "$PAIMON_UI_HOME/config:$PAIMON_UI_HOME/libs/*" \
    org.apache.paimon.web.server.PaimonWebServerApplication \
    > /dev/null 2>&1 &
  echo "Paimon Web Server started in daemon."
else
  $JAVA_HOME/bin/java $JAVA_OPTS \
    -cp "$PAIMON_UI_HOME/config:$PAIMON_UI_HOME/libs/*" \
    org.apache.paimon.web.server.PaimonWebServerApplication
fi
