sig nested-sequents.

accum_sig lists.
accum_sig base.
accum_sig lmf-singlefoc.

kind nested-sequent-state type.
% in addition to the two values of the state of singlefoc, we also keep track of two things
% a counter over the second index in the nested pair which correspond to children
% when we apply a box and we are inside nested sequent O, we need to create (chld i O)
% i is cumpted using the counter which tracks the current value for O)
% a map between the nested indices and the singlefoc ones
type nested-sequent-state list (pair index nat) -> list (pair index index) -> list (pair index index) -> list index -> list (pair index atm) -> nested-sequent-state.

type nested-sequent-node index -> index -> lmf-node.

% nsequents have different indices than the rest of the system
% an index is a pair of the index of the formula (as before) and the index of the nested sequent
% the first component is generated just from lind, rind, none, root. The secon is generated from
% a constructor chld taking an index (child #) and parent chld index

type ns index -> index -> index.
type chld nat -> index -> index.
type zb index.

type nested-sequent-cert nested-sequent-state -> lmf-tree -> cert.

type nested-sequent-to-lmf-singlefoc cert -> index -> index -> cert -> o.
type lmf-singlefoc-to-nested-sequent cert -> list (pair index nat) -> list (pair index index)-> list (pair index index) -> index -> cert -> o.

type convert-index list (pair index index) -> index -> index -> o.
type add_to_map list (pair index index) -> index -> index -> list (pair index index) -> o.
type get_incremented_child list (pair index nat) -> index -> index -> list (pair index nat) -> o.

kind nat type.
type znat nat.
type snat nat -> nat.


