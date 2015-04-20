#!/bin/sh
# Copyright (C) 2013 INRIA and Microsoft Corporation

BASEDIR="`pwd`"
RUNNER_BASE=$BASEDIR/TOOLS/runner.file
RUNNER_TARGET=$BASEDIR/runner.mod
export CMD="tjsim -b runner -s run."

ARGS=("$@")
ELEMENTS=${#ARGS[@]}

rm -f $RUNNER_TARGET

echo -e "module runner.\\n" >> $RUNNER_TARGET

if [ $ELEMENTS = 0 ]
  then echo "Error: at least one certificate must be given!"
  else
  for (( i=0;i<$ELEMENTS;i++)); do
        echo -e "accumulate ${ARGS[${i}]}." >> $RUNNER_TARGET
  done

  echo $(cat $RUNNER_BASE) >> $RUNNER_TARGET

  make debug>/dev/null && $CMD && rm -f $RUNNER_TARGET
fi
