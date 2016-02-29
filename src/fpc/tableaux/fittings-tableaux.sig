sig fittings-tableaux.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.

kind dectree, opindex type.

% a certificate is a tuple of:
% list of indices -
% tree of pairs of indices -
% list of pairs - a mapping from indices to LKF-eigenvariables
type fitcert list index -> dectree -> list (pair index atm) -> cert.

% a dectree is a tree of (index, opindex)
% index - referring to the position in the tableau inference tree
% opindex - optional index referring to complementary formula position for boxes and closures.
% represented as a root (index, opindex) plus a list of dectrees (containing from 0 to 2 dectrees; 0, if the node is a leaf)
type dectree index -> opindex -> list dectree -> dectree.

%type decnode index -> opindex -> decnode.
%type udectree decnode -> dectree -> dectree.
%type bdectree decnode -> dectree -> dectree -> dectree.

type eind index.
type lind index -> index.
type rind index -> index.
type bind index -> index -> index.

type sind index -> opindex.
type none opindex.

% kind fittab, tabinf, label type.

% type idx int -> index.
% type lbl int -> label.
% type fittab list tabinf -> cert.
%type conjinf  index -> int -> int -> tabinf.
%type disjinf  index -> int -> int -> tabinf.
%type diainf index -> int -> label -> tabinf.
%type boxinf index -> int -> label -> tabinf.
%type close index -> tabinf.

