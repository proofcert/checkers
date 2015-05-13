# Running tptpparser on the directory and put the output in the second folder

cur="`pwd`"
eout_dir=$1
modout_dir=$2

ep_name="eproblem"
tptp_parser=$1/../tstpparser/tstpparser

ecode=/tmp/ecode.$$.log

COUNTER=0
cd $eout_dir
for problem in `ls -d *.out | sed 's/\(.*\)\..*/\1/'`
  do
    echo "-1" >$ecode
    echo "Running tstpparser on $problem"
    $tptp_parser "$problem.out" $problem
    echo $? | tr -d "\n" >$ecode
    if [ $? == 0 ] ; then
      mv $problem.mod $modout_dir
      mv $problem.sig $modout_dir
      let COUNTER=COUNTER+1
      else
          rm -f $problem.mod
          rm -f $problem.sig
    fi
  done
cd $cur
echo "$COUNTER problems were parsed successfully"
