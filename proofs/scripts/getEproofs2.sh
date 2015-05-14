#!/bin/bash
# This should be run from the top level dir of the TPTP lib.

cur="`pwd`"
src="$cur/src"
tptp_dir=$1
ep_name="eproblem"
tptp_parser=$cur/proofs/tstpparser/tstpparser
prover=$cur/prover.sh
prob_dir="$tptp_dir/Small"
opts="--tstp-format --proof-object --output-level=2"
eprover_to=$2
tdir=$cur/$3

ecode=/tmp/ecode.$$.log
cert_res=/tmp/res.$$.log

outf="$cur/output.txt"

echo -e "problem\teprover\n" > $outf
cd $tptp_dir
for problem in `ls -d $prob_dir/*.p`
  do
    echo "-1" > $ecode
    file_name="`basename ${problem} | sed -e 's/\..*//'`"
    echo "Running eprover on $problem"
    timeout $eprover_to eprover $opts < $problem > "$tdir/$file_name.out"
    echo $? | tr -d "\n" > $ecode
    evErr="`cat $ecode`"
    echo -e "$file_name\t$evErr\n" >> $outf
done
