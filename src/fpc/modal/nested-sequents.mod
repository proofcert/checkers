module nested-sequents.

accumulate lmf-singlefoc.
accumulate debug.
accumulate lists.

% helpers
nested-sequent-to-lmf-singlefoc
  (nested-sequent-cert (nested-sequent-state _ _ _ L1 L2) (lmf-tree (nested-sequent-node _ _) T)) I O
  (lmf-singlefoc-cert (lmf-singlefoc-state L1 L2) (lmf-tree (lmf-singlefoc-node I O) T)).

lmf-singlefoc-to-nested-sequent
  (lmf-singlefoc-cert (lmf-singlefoc-state L1 L2) (lmf-tree (lmf-singlefoc-node _ O) T)) Map1 Map2 Map3 I
  (nested-sequent-cert (nested-sequent-state Map1 Map2 Map3 L1 L2) (lmf-tree (nested-sequent-node I O) T)) :- !.
lmf-singlefoc-to-nested-sequent
  (lmf-singlefoc-cert (lmf-singlefoc-state L1 L2) T) Map1 Map2 Map3 _
  (nested-sequent-cert (nested-sequent-state Map1 Map2 Map3 L1 L2) T).

convert-index Map I I' :-
  member (pr I I') Map.

add_to_map Map I I' [pr I I' | Map].

get_incremented_child Map Ch (chld (snat Int) Ch) [pr Ch (snat Int) | Map'] :-
  memb_and_rest (pr Ch Int) Map Map'.

% in conversion, store uses the index in the set, we need to use the index from single
% initial map is root -> ns root zero

decide_ke Cert I' Cert' :-
  Cert = (nested-sequent-cert (nested-sequent-state Counter Boxes Map V M) (lmf-tree (nested-sequent-node I O) D)),
  convert-index Map I I-s,
  nested-sequent-to-lmf-singlefoc Cert I-s O Cert-s,
  decide_ke Cert-s I' Cert-s',
  lmf-singlefoc-to-nested-sequent Cert-s' Counter Boxes Map I Cert'.

store_kc Cert Form H Cert' :-
  Cert = (nested-sequent-cert (nested-sequent-state Counter Boxes Map V M) T),
  spy "rec " (store_kc (lmf-singlefoc-cert (lmf-singlefoc-state V M) T) Form H Cert-s'),
  lmf-singlefoc-to-nested-sequent Cert-s' Counter Boxes Map I Cert'.

release_ke C C.

initial_ke (nested-sequent-cert (nested-sequent-state Counter Boxes Map V M) (lmf-tree (nested-sequent-node I O) D)) O' :-
  convert-index Map O O'.

orNeg_kc Cert Val Cert' :-
  Cert = (nested-sequent-cert (nested-sequent-state Counter Boxes Map V M) (lmf-tree (nested-sequent-node I O) D)),
  convert-index Map I I-s,
  I = (ns Ind Ch),
  nested-sequent-to-lmf-singlefoc Cert I-s O Cert-s,
  orNeg_kc Cert-s Val Cert-s',
  Cert-s' = (lmf-singlefoc-cert (lmf-singlefoc-state [I1,I2] _) _),
  add_to_map Map (ns (lind Ind) Ch) I1 Map1,
  add_to_map Map1 (ns (rind Ind) Ch) I2 Map2,
  lmf-singlefoc-to-nested-sequent Cert-s' Counter Boxes Map2 _ Cert'.

orNeg_kc (nested-sequent-cert (nested-sequent-state A B C [E|L] D) T) _ (nested-sequent-cert (nested-sequent-state A B C [E|L] D) T).

andNeg_kc Cert _ Cert1 Cert2 :-
  Cert = (nested-sequent-cert (nested-sequent-state Counter Boxes Map V M) (lmf-tree (nested-sequent-node I O) D)),
  convert-index Map I I-s,
  I = (ns Ind Ch),
  nested-sequent-to-lmf-singlefoc Cert I-s O Cert-s,
  andNeg_kc Cert-s _ Cert-s1 Cert-s2,
  Cert-s1 = (lmf-singlefoc-cert (lmf-singlefoc-state [I1] _) _),
  add_to_map Map (ns (lind Ind) Ch) I1 Map1,
  lmf-singlefoc-to-nested-sequent Cert-s1 Counter Boxes Map1 _ Cert1,
  Cert-s2 = (lmf-singlefoc-cert (lmf-singlefoc-state [I2] _) _),
  add_to_map Map (ns (rind Ind) Ch) I2 Map2,
  lmf-singlefoc-to-nested-sequent Cert-s2 Counter Boxes Map2 _ Cert2.

andPos_k
  (nested-sequent-cert S T)
  _
  left-first
  (lmf-singlefoc-cert (lmf-singlefoc-state D E) (lmf-tree (lmf-singlefoc-node _ none) []))
  (nested-sequent-cert S T) :-
  S = (nested-sequent-state A B C D E).

%  (lmf-singlefoc-cert (lmf-singlefoc-state [] M) (lmf-tree (lmf-singlefoc-node I O) [H|T]))
all_kc Cert
  (Eigen\ nested-sequent-cert (nested-sequent-state NewCounter Boxes' Map' [lind I-s] [pr I-s Eigen|M]) D) :-
  Cert = (nested-sequent-cert (nested-sequent-state Counter Boxes Map [] M) (lmf-tree (nested-sequent-node I O) [D])),
  convert-index Map I I-s,
  I = (ns Ind Ch),
  get_incremented_child Counter Ch NewCh NewCounter,
  nested-sequent-to-lmf-singlefoc Cert I-s O Cert-s,
  add_to_map Boxes NewCh I-s Boxes',
  add_to_map Map (ns I NewCh) (lind I-s) Map'.

some_ke Cert X Cert' :-
  Cert = (nested-sequent-cert (nested-sequent-state Counter Boxes Map V M) (lmf-tree (nested-sequent-node I O) D)),
  convert-index Map I I-s,
  convert-index Boxes O O',
  nested-sequent-to-lmf-singlefoc Cert I-s O' Cert-s,
  some_ke Cert-s X Cert-s',
  Cert-s' = (lmf-singlefoc-cert (lmf-singlefoc-state [I'] _) _),
  I = (ns II _),
  add_to_map Map (ns II O) I' Map',
  lmf-singlefoc-to-nested-sequent Cert-s' Counter Boxes Map' _ Cert'.
