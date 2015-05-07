# This should be run from the top level dir of the TPTP lib.

cur="`pwd`"
src="$cur/src"
tptp_dir=$1
ep_name="eproblem"
tptp_parser=$cur/proofs/tstpparser/tstpparser
prover=$cur/prover.sh
prob_dir="$tptp_dir/Problems"
opts="--tstp-format --proof-object --output-level=2 --cpu-limit"
eprover_to=$2

ecode1=/tmp/ecode1.$$.log
ecode2=/tmp/ecode2.$$.log
ecode3=/tmp/ecode3.$$.log
ecode4=/tmp/ecode4.$$.log
cert_res=/tmp/res.$$.log

errors=0
total=0
content=""
totaltime=0
outf=output.txt

echo -e "problem\teprover\ttstp_parser\tcertifier_err\tcertifier_fail\n" > $outf
cd $tptp_dir
for prob_group in `ls -d $prob_dir/*`
do
  echo "Processing directory $prob_group"
  for problem in `ls -d $prob_group/*.p`
  do
    echo "-1" >$ecode1
    echo "-1" >$ecode2
    echo "-1" >$ecode3
    echo "-1" >$ecode4
    file_name="${problem}.eprover---1.9.proof"
    echo "Running eprover on $problem"
    timeout $eprover_to eprover $opts < $problem > $file_name
    echo $? | tr -d "\n" >$ecode1
    # deleting uninteresting lines
    sed '/^# Proof found/,$d' $file_name > "${file_name}.out"
    # Deleting unused file
    rm $file_name
    mv "${file_name}.out" "$src/problem.out"
    cd $src
    echo "Running tstpparser on src/problem.out"
    timeout 5 $tptp_parser "problem.out" $ep_name
    echo $? | tr -d "\n" >$ecode2
    rm "problem.out"
    cd ..
    echo "Certifying $ep_name"
    timeout 15 $prover $ep_name > $cert_res
    echo $? | tr -d "\n" > $ecode3
    grep "Success" $cert_res
    echo $? | tr -d "\n" > $ecode4
    rm "$src/$ep_name.*"
    echo -en "$problem\t" >> $outf
    cat $ecode1 >> $outf
    echo -en "\t" >> $outf
    cat $ecode2 >> $outf
    echo -en "\t" >> $outf
    cat $ecode3 >> $outf
    echo -en "\t" >> $outf
    cat $ecode4 >> $outf
    echo -en "\n" >> $outf
    cd $tptp_dir
  done
done
