sig fittings-tableaux.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.

kind dectree, decnode, option type.

% a certificate is a tuple of:
% list of indices - 
% tree of pairs of indices - 
% list of pairs - 
type fitproof list index -> dectree -> list pr -> cert.

% an ntree is a tuple of
% index - referring to the position in the tableau inference tree
% option - optional index referring to complementary formula position for boxes and closures.
% list ntree - list of subtrees

%type unode index -> option -> ntree -> ntree.

type decnode index -> option -> decnode.
type udectree decnode -> dectree -> dectree.
type bdectree decnode -> dectree -> dectree -> dectree.

type eind index.
type lind index -> index.
type rind index -> index.

type sindex index -> option
type none -> option

% kind fittab, tabinf, label type.

% type idx int -> index.
% type lbl int -> label.
% type fittab list tabinf -> cert.
%type conjinf  index -> int -> int -> tabinf.
%type disjinf  index -> int -> int -> tabinf.
%type diainf index -> int -> label -> tabinf.
%type boxinf index -> int -> label -> tabinf.
%type close index -> tabinf.

