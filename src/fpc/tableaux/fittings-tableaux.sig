sig fittings-tableaux.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.

kind dectree type.

% a certificate is a tuple of:
% list of indices - used when formulas get stored
% tree of pairs of indices - represents the original tableau proof
% list of pairs - a mapping from indices to LKF-eigenvariables
type fitcert list index -> dectree -> list (pair index atm) -> cert.

% a dectree is a tree of (index1, index2)
% index1 - referring to the position of the subformula in the formula tree
% index2 - optional index referring to complementary formula position for boxes and closures.
% represented as a root (index1, index2) plus a list of dectrees (containing from 0 to 2 dectrees; 0, if the node is a leaf)
type dectree index -> index -> list dectree -> dectree.

% an index is (1) empty, the (2) left or (3) right child of an index (this is used for classical connectives and diamond), 
% (4) the box child of an index (in this case, we also add info about the corresponding diamond)
type eind index. % corresponds to the root
type lind index -> index.
type rind index -> index.
type bind index -> index -> index.
type none index. % used when the index is irrelevant, e.g., to label relational atoms

% for the accessibility relation, we use the same 'rel' in all problems
type rel A -> A -> atm.