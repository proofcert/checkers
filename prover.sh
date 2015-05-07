#!/bin/sh
# Copyright (C) 2015 INRIA

BASEDIR="`pwd`"
SRCDIR=$BASEDIR/src
TOOLS=$SRCDIR/TOOLS
RUNNER_MOD_BASE=$TOOLS/runner.mod.file
RUNNER_SIG_BASE=$TOOLS/runner.sig.file
RUNNER_MOD_TARGET=$SRCDIR/runner.mod
RUNNER_SIG_TARGET=$SRCDIR/runner.sig
export CMD="tjsim -b runner -s run."

ARGS=("$@")
ELEMENTS=${#ARGS[@]}

rm -f $RUNNER_MOD_TARGET
rm -f $RUNNER_SIG_TARGET

echo -e "module runner.\\n" >> $RUNNER_MOD_TARGET
echo -e "sig runner.\\n" >> $RUNNER_SIG_TARGET

if [ $ELEMENTS = 0 ]
  then echo "Error: at least one certificate must be given!"
  else
  for (( i=0;i<$ELEMENTS;i++)); do
        echo -e "accum_sig ${ARGS[${i}]}." >> $RUNNER_SIG_TARGET
        echo -e "accumulate ${ARGS[${i}]}." >> $RUNNER_MOD_TARGET
  done

  echo $(cat $RUNNER_SIG_BASE) >> $RUNNER_SIG_TARGET
  echo $(cat $RUNNER_MOD_BASE) >> $RUNNER_MOD_TARGET

  cd $SRCDIR && make>/dev/null && $CMD  && rm -f $RUNNER_MOD_TARGET $RUNNER_SIG_TARGET
fi
