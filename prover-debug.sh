#!/bin/sh
# Copyright (C) 2015 INRIA

BASEDIR="`pwd`"
SRCDIR=$BASEDIR/src
TOOLS=$SRCDIR/TOOLS
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

cp $SRCDIR/*.sig $DEBUG
cp -f $SRCDIR/*.mod $DEBUG
cp `find $SRCDIR/kernel -name "*.sig"` $DEBUG
cp `find $SRCDIR/utils -name "*.sig"` $DEBUG
cp `find $SRCDIR/fpc -name "*.sig"` $DEBUG
cp `find $SRCDIR/tests -name "*.sig"` $DEBUG
cp `find $SRCDIR/kernel -name "*.mod"` $DEBUG
cp `find $SRCDIR/utils -name "*.mod"` $DEBUG
cp `find $SRCDIR/fpc -name "*.mod"` $DEBUG
cp `find $SRCDIR/tests -name "*.mod"` $DEBUG
cp $TOOLS/kernel_debug/lkf-kernel.mod.debug $DEBUG/lkf-kernel.mod
cp $TOOLS/Makefile.debug $DEBUG/Makefile

echo -e "module runner.\\n" >> $RUNNER_MOD_TARGET
echo -e "sig runner.\\n" >> $RUNNER_SIG_TARGET

if [ $ELEMENTS -ne 1 ]
  then echo "Error: at least one certificate must be given!"
  else
  for (( i=0;i<$ELEMENTS;i++)); do
        echo -e "accum_sig ${ARGS[${i}]}." >> $RUNNER_SIG_TARGET
        echo -e "accumulate ${ARGS[${i}]}." >> $RUNNER_MOD_TARGET
  done

  echo $(cat $RUNNER_SIG_BASE) >> $RUNNER_SIG_TARGET
  echo $(cat $RUNNER_MOD_BASE) >> $RUNNER_MOD_TARGET

  cd $DEBUG && make>/dev/null && $CMD
  rm -rf $DEBUG
fi
