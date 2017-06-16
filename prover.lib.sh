
function init(){
BASEDIR="`pwd`"
SRCDIR=$BASEDIR/src
TOOLS=$SRCDIR/TOOLS
RUNNER_MOD_BASE=$TOOLS/runner.mod.file
RUNNER_SIG_BASE=$TOOLS/runner.sig.file
MODNAME=${MODNAME:-runner}
RUNNER_MOD_TARGET=$SRCDIR/${MODNAME}.mod
RUNNER_SIG_TARGET=$SRCDIR/${MODNAME}.sig
}

function cleanup(){
rm -f $SRCDIR/kernel/lkf/lkf-kernel.lpo $SRCDIR/kernel/lkf/lkf-kernel.lp $SRCDIR/kernel/lkf/lkf-kernel.mod
cp $TOOLS/kernel_debug/lkf-kernel.mod$DEBUG $SRCDIR/kernel/lkf/lkf-kernel.mod

rm -f $RUNNER_MOD_TARGET
rm -f $RUNNER_SIG_TARGET
}

function parse_args() {
ARGS=()
while [ ! -z "$1" ]; do
	case $1 in
	--module-name)
		shift
		MODNAME="runner$1"
	;;
	--prepare-only)
		NO_RUN=true
	;;
  --debug)
		DEBUG=".debug"
	;;
	--run-only)
		NO_PREPARE=true
	;;
	*)
		ARGS+="$1"
	;;
	esac
	shift
done
ELEMENTS=${#ARGS[@]}
}
