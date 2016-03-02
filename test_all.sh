#!/bin/bash

# argument is the test directory name, i.e. tableaux, eprover, etc.

BASEDIR="`pwd`"
TESTDIR=$BASEDIR/src/tests/$1

eVal() {
  eval "$1"
}


find "$TESTDIR" -type f -name "*.mod" | (

while read f; do
    FILE="`basename $f .mod`"
    echo "testing $FILE"
    echo | (eVal "$BASEDIR/prover.sh $FILE")
  done
  )


