module nested-sequents-lmf.

accumulate debug.
accumulate lists.

convert-index Map I I' :-
  member (pr I I') Map.

add_to_map Map I I' [pr I I' | Map].

get_incremented_child Map Ch (chld (snat Int) Ch) [pr Ch (snat Int) | Map'] :-
  memb_and_rest (pr Ch Int) Map Map'.

% in conversion, store uses the index in the set, we need to use the index from single
% initial map is root -> ns root zero

decide_ke Cert I' Cert :-
  Cert = (nested-sequent-cert (nested-sequent-state Counter Boxes Map V M) (lmf-tree (nested-sequent-node I O) D)),
  convert-index Map I I'.

% we need two stores because a store on a negative literal should be able to access the index in the node
% therefore, we need to translate the node (see more in singlefoc)
store_kc
  (nested-sequent-cert (nested-sequent-state Counter Boxes Map [H|D] M) T)
  Form
  H
  (nested-sequent-cert (nested-sequent-state Counter Boxes Map D M) T).

release_ke C C.

initial_ke (nested-sequent-cert (nested-sequent-state Counter Boxes Map V M) (lmf-tree (nested-sequent-node I O) D)) O' :-
  convert-index Map O O'.

orNeg_kc
	(nested-sequent-cert (nested-sequent-state Counter Boxes Map V M) (lmf-tree (nested-sequent-node I O) D))
	_
	(nested-sequent-cert (nested-sequent-state Counter Boxes Map V M) (lmf-tree (nested-sequent-node I O) D)) :-
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
  add_to_map Map (ns Ind NewCh) (lind I-s) Map'.

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
