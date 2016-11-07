sig nested-sequents.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.
accum_sig lmf-star.
accum_sig nested-sequents-syntax.

kind nested-sequent-state type.
type nested-sequent-state list A -> A -> list (pair index A) -> int -> list index -> list (pair index atm) -> nested-sequent-state.

type nested-sequent-node index -> index -> lmf-node.

% nsequents have different indices than the rest of the system
% an index is a pair of the index of the formula (as before) and the index of the nested sequent
% the first component is generated just from lind, rind, none, root. The secon is generated from
% a constructor chld taking an index (child #) and parent chld index

kind chld type.
type ns index -> chld -> index.
type chld int -> chld -> chld.
type zb chld.

type nested-sequent-cert nested-sequent-state -> lmf-tree -> cert.

type nested-sequent-to-lmf-star cert -> cert -> o.
type lmf-star-to-nested-sequent cert -> cert -> o.


