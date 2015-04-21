#!/bin/sh
# Copyright (C) 2015 INRIA

BASEDIR="`pwd`"
TOOLS=$BASEDIR/TOOLS
DEBUG=$BASEDIR/_debug
RUNNER_MOD_BASE=$TOOLS/runner.mod.file
RUNNER_SIG_BASE=$TOOLS/runner.sig.file
RUNNER_MOD_TARGET=$DEBUG/runner.mod
RUNNER_SIG_TARGET=$DEBUG/runner.sig

export CMD="tjsim -b runner -s run."

ARGS=("$@")
ELEMENTS=${#ARGS[@]}

rm -rf $DEBUG
mkdir $DEBUG

cp $BASEDIR/base.sig $DEBUG
cp `find $BASEDIR/kernel -name "*.sig"` $DEBUG
cp `find $BASEDIR/utils -name "*.sig"` $DEBUG
cp `find $BASEDIR/fpc -name "*.sig"` $DEBUG
cp `find $BASEDIR/tests -name "*.sig"` $DEBUG
cp `find $BASEDIR/kernel -name "*.mod"` $DEBUG
cp `find $BASEDIR/utils -name "*.mod"` $DEBUG
cp `find $BASEDIR/fpc -name "*.mod"` $DEBUG
cp `find $BASEDIR/tests -name "*.mod"` $DEBUG
cp $TOOLS/kernel_debug/lkf-kernel.mod.debug $DEBUG/lkf-kernel.mod
cp $TOOLS/Makefile.debug $DEBUG/Makefile

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

  cd $DEBUG && make>/dev/null && $CMD
fi
