sig fittings-tableaux.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.

kind dectree type.

% a certificate is a tuple of:
% list of indices - 
% tree of pairs of indices - 
% list of pairs - a mapping from indices to LKF-eigenvariables 
type fitcert list index -> dectree -> list pr -> cert.

% a dectree is a tree of (index1, index2)
% index - referring to the position in the tableau inference tree
% opindex - optional index referring to complementary formula position for boxes and closures.
% represented as a root (index, opindex) plus a list of dectrees (containing from 0 to 2 dectrees; 0, if the node is a leaf)
type dectree index -> opindex -> list dectree -> dectree.

% an index is (1) empty, the (2) left or (3) right child of an index (this is used for classical connectives and diamond), 
% (4) the box child of an index (in this case, we also add info about the corresponding diamond)
type eind index.
type lind index -> index.
type rind index -> index.
type bind index -> index -> index.


% OLD STUFF

%type decnode index -> opindex -> decnode.
%type udectree decnode -> dectree -> dectree.
%type bdectree decnode -> dectree -> dectree -> dectree.

%type sind index -> opindex
%type none -> opindex

% kind fittab, tabinf, label type.

% type idx int -> index.
% type lbl int -> label.
% type fittab list tabinf -> cert.
%type conjinf  index -> int -> int -> tabinf.
%type disjinf  index -> int -> int -> tabinf.
%type diainf index -> int -> label -> tabinf.
%type boxinf index -> int -> label -> tabinf.
%type close index -> tabinf.

