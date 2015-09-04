#!/bin/bash
# Copyright (C) 2015 INRIA

source prover.lib.sh

parse_args "$@"
init

if [ -z "$NO_PREPARE" ]; then

  cleanup

  echo -e "module ${MODNAME}.\\n" >> $RUNNER_MOD_TARGET
  echo -e "sig ${MODNAME}.\\n" >> $RUNNER_SIG_TARGET

  if [ $ELEMENTS -ne 1 ]
    then echo "Error: exactly one certificate must be given!"
    else
    for (( i=0;i<$ELEMENTS;i++)); do
          echo -e "accum_sig ${ARGS[${i}]}.\\n" >> $RUNNER_SIG_TARGET
          echo -e "accumulate ${ARGS[${i}]}.\\n" >> $RUNNER_MOD_TARGET
    done
  
    `cat $RUNNER_SIG_BASE >> $RUNNER_SIG_TARGET`
    `cat $RUNNER_MOD_BASE >> $RUNNER_MOD_TARGET`
  
      cd $SRCDIR && \
      make clean>/dev/null && \
      make>/dev/null
  fi
fi


export CMD="tjsim -b ${MODNAME} -s run."
if [ -z "$NO_RUN" ]; then
    cd $SRCDIR && \
    $CMD && \
    rm -f $RUNNER_MOD_TARGET $RUNNER_SIG_TARGET
fi
