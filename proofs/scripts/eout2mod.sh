# Running tptpparser on the directory and put the output in the second folder

cur="`pwd`"
eout_dir=$1
modout_dir=$cur/$2

ep_name="eproblem"
tptp_parser=../tstpparser/tstpparser
timeout=$3

ecode=/tmp/ecode.$$.log
outf="$cur/parser_out.txt"

COUNTER=0
cd $eout_dir
echo -e "problem\tparser_code\n" > $outf
for problem in `ls -d *.out`
  do
    echo "-1" >$ecode
    echo "Running tstpparser on $problem"
    PNAME=`ls -d $problem | sed -e "s/-.*//" | sed -e "s/\(.*\)/\L\1/"`
    timeout $timeout $tptp_parser "$problem" $PNAME
    echo $? | tr -d "\n" >$ecode
    let V=`cat $ecode`
    if [ $V == 0 ] ; then
      echo "Copying files to $modout_dir"
      mv $PNAME.mod $modout_dir
      mv $PNAME.sig $modout_dir
      let COUNTER=COUNTER+1
      echo -e "$PNAME\tSuccess\n" >> $outf
    else
      rm -f $PNAME.mod
      rm -f $PNAME.sig
      echo -e "$PNAME\t$V\n" >> $outf
    fi
  done
cd $cur
echo "$COUNTER problems were parsed successfully"
