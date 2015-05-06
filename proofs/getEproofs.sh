
# This should be run from the top level dir of the TPTP lib.

prob_dir="Problems"
opts="--tstp-format --proof-object --output-level=2"

for prob_group in `ls -d $prob_dir/*`
do
  echo "Processing directory $prob_group"
  for problem in `ls -d $prob_group/*.p`
  do
    file_name="${problem}.eprover---1.9.proof"
    eprover $opts < $problem > $file_name
    # deleting uninteresting lines
    sed '/^# Proof found/,$d' $file_name > "${file_name}.out"
  done
done
