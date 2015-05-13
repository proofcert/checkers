# Running tptpparser on the directory and put the output in the second folder

cur="`pwd`"
eout_dir=$1
modout_dir=$2

ep_name="eproblem"
tptp_parser=$1/../tstpparser/tstpparser

ecode=/tmp/ecode.$$.log

COUNTER=0
cd $eout_dir
for problem in `ls -d *.out`
  do
    echo "-1" >$ecode
    echo "Running tstpparser on $problem"
    PNAME=`ls -d $problem | sed -e "s/-.*//" | sed -e "s/\(.*\)/\L\1/"`
    $tptp_parser "$problem" $PNAME
    echo $? | tr -d "\n" >$ecode
    if [ $? == 0 ] ; then
      mv $PNAME.mod $modout_dir
      mv $PNAME.sig $modout_dir
      let COUNTER=COUNTER+1
      else
          rm -f $PNAME.mod
          rm -f $PNAME.sig
    fi
  done
cd $cur
echo "$COUNTER problems were parsed successfully"
