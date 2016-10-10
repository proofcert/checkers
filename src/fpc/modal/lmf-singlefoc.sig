sig lmf-singlefoc.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.

kind eigenlist type.
kind singlefoc-evidence type.

type eigenlist list (pair index atm) -> eigenlist.

% a singlefoc-evidence is a tree of (index1, index2)
% index1 - referring to the position of the subformula in the formula tree
% index2 - optional index referring to complementary formula position for diamonds and closures.
% represented as a root (index1, index2) plus a list of singlefoc-evidences  
type singlefoc-evidence index -> index -> list singlefoc-evidence -> singlefoc-evidence.

% a single-foc certificate is a tuple of:
% list of indices - used when formulas get stored
% tree of pairs of indices - represents the original proof (the proof evidence)
% list of pairs - a mapping from indices to LKF-eigenvariables
type singlefoc-cert list index -> singlefoc-evidence -> eigenlist -> cert.

% an index is (1) empty, the (2) left or (3) right child of an index (this is used for classical connectives and diamond), 
% (4) the diamond-child of an index (in this case, we also add info about the corresponding box, i.e., eigenvariable)
type root index. % corresponds to the root
type lind index -> index.
type rind index -> index.
type diaind index -> index -> index.
type none index. % used when the index is irrelevant, e.g., to label relational atoms

% for the accessibility relation, we use the same 'rel' in all problems
type rel A -> A -> atm.