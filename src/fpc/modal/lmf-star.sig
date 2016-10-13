sig lmf-star.


accum_sig certificatesLKF.
accum_sig lmf.
accum_sig lists.
accum_sig base.

% a certificate is a tuple of:
% list of indices - used when formulas get stored
% tree of pairs of indices - represents the original proof (the proof evidence)
% list of pairs - a mapping from indices to LKF-eigenvariables
type star-cert list index -> star-evidence -> list (pair index atm) -> cert.
type star-cert lmf-cert  -> cert.

% a star-evidence is a tree of (index1, index2)
% index1 - referring to the position of the subformula in the formula tree
% index2 - optional index referring to complementary formula position for diamonds and closures.
% represented as a root (index1, index2) plus a list of star-evidences (containing from 0 to 2 star-evidences; 0, if the node is a leaf)
type star-evidence list (index -> index -> list index) -> list star-evidence -> star-evidence.
type star-evidence lmf-evidence ->  star-evidence.
% in order to have formula futures of arbitrary length, the first element should be
% list (index -> list index -> list index)


% an index is (1) empty, the (2) left or (3) right child of an index (this is used for classical connectives and diamond),
% (4) the diamond-child of an index (in this case, we also add info about the corresponding box, i.e., the eigenvariable)
%type eind index. % corresponds to the root
%type lind index -> index.
%type rind index -> index.
%type diaind index -> index -> index.
%type none index. % used when the index is irrelevant, e.g., to label relational atoms

% for the accessibility relation, we use the same 'rel' in all problems
%type rel A -> A -> atm.
