#!/bin/bash
# Copyright (C) 2015 INRIA

source prover.lib.sh

parse_args "$@"
init
RUNNER_MOD_TARGET="${RUNNER_MOD_TARGET%%.mod}.elpi"

if [ -z "$NO_PREPARE" ]; then

  cleanup


  echo -e "module  ${MODNAME}.\\n" >> $RUNNER_MOD_TARGET

  if [ $ELEMENTS -lt 1 ]
    then echo "Error: at least one certificate must be given!"
    else
    for (( i=0;i<$ELEMENTS;i++)); do
          echo -e "accumulate ${ARGS[${i}]}.\\n" >> $RUNNER_MOD_TARGET
    done

    `cat $RUNNER_MOD_BASE >> $RUNNER_MOD_TARGET`
    echo 'main :- run.' >> $RUNNER_MOD_TARGET
  fi
fi

export CMD="elpi${VARIANT} -test ${MODNAME}.elpi"
#export CMD="elpi${VARIANT} -no-tc -test ${MODNAME}.elpi"
if [ -z "$NO_RUN" ]; then
    cd $SRCDIR && \
    source TJPATH && \
    $CMD && \
    rm -f $RUNNER_MOD_TARGET
fi

