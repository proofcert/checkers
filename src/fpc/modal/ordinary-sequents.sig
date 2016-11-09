sig ordinary-sequents.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.
accum_sig lmf-star.

% similar to lmf-singlefoc node. we store the index of the node and an optional
% value which maps to the complementary literal or to the box if it is a diamond.
% but, since we dont have diamond rules, the option will be associated to boxes
% and will contain a list of diamond indices which are being applied at the same time.

kind ordinary-sequent-state type.
type ordinary-sequent-state list A -> A -> list (pair index A) -> int -> list index -> list (pair index atm) -> ordinary-sequent-state.

type ordinary-sequent-node index -> list index -> lmf-node.

% just with an lmf-star cert
type ordinary-sequent-cert ordinary-sequent-state -> lmf-tree -> cert.

type generate_diamonds index -> list index -> list lmf-tree -> list lmf-tree -> list A -> A -> int -> o.
%type generate_diamonds index -> list index -> list lmf-tree -> list lmf-tree -> A -> int -> o.

type ordinary-sequent-to-lmf-star cert -> list index -> cert -> o.
type lmf-star-to-ordinary-sequent cert -> list index -> cert -> o.
type ordinary-sequent-to-lmf-star-with-op-index cert -> cert -> o.
