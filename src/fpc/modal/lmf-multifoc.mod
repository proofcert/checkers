module lmf-multifoc.

accumulate lmf-singlefoc.
accumulate debug.

% mv: in this version, we do not store relational atoms with a proper label
%  for extensions of K, it would be necessary to do it:
%  Idea: add a constructor
% type relind index -> index -> index.
%  where the two indexes refer to the formulas that introduced the two worlds

% helpers

% translate without recursing
lmf-multifoc_to_lmf-singlefoc
  (lmf-multifoc-cert (lmf-singlefoc-cert S (lmf-tree (lmf-multifoc-node M N) C)))
  M
  (lmf-singlefoc-cert S (lmf-tree N C)).

lmf-singlefoc_to_lmf-multifoc
  (lmf-singlefoc-cert S (lmf-tree (lmf-singlefoc-node I O) C))
  M
  (lmf-multifoc-cert (lmf-singlefoc-cert S (lmf-tree (lmf-multifoc-node M (lmf-singlefoc-node I O)) C))).

% node can also be star, etc.
lmf-singlefoc_to_lmf-multifoc
  (lmf-singlefoc-cert S (lmf-tree N C))
  _
  (lmf-multifoc-cert (lmf-singlefoc-cert S (lmf-tree N C))).

lmf-singlefoc_to_lmf-multifoc_all
  Cert
  (w\ lmf-multifoc-cert (Cert w)).

% decide does not recurse on tree so we need to change back and forth the root node
decide_ke Cert L Cert' :-
  lmf-multifoc_to_lmf-singlefoc Cert M Cert-s,
  decide_ke Cert-s L Cert-s',
  lmf-singlefoc_to_lmf-multifoc Cert-s' M Cert'.

store_kc Cert L B Cert' :-
  lmf-multifoc_to_lmf-singlefoc Cert M Cert-s,
  store_kc Cert-s L B Cert-s',
  lmf-singlefoc_to_lmf-multifoc Cert-s' M Cert'.

release_ke Cert Cert.

initial_ke Cert O :-
  lmf-multifoc_to_lmf-singlefoc Cert _ Cert-s,
  initial_ke Cert-s O.

orNeg_kc Cert Form Cert' :-
  lmf-multifoc_to_lmf-singlefoc Cert M Cert-s,
  orNeg_kc Cert-s Form Cert-s',
  lmf-singlefoc_to_lmf-multifoc Cert-s' M Cert'.

andNeg_kc Cert Form Cert1 Cert2 :-
  lmf-multifoc_to_lmf-singlefoc Cert M Cert-s,
  andNeg_kc Cert-s Form Cert-s1 Cert-s2,
  lmf-singlefoc_to_lmf-multifoc Cert-s1 M Cert1,
  lmf-singlefoc_to_lmf-multifoc Cert-s2 M Cert2.

andPos_k Cert Form Str Cert1 Cert2 :-
  lmf-multifoc_to_lmf-singlefoc Cert M Cert-s,
  andPos_k Cert-s Form Str Cert-s1 Cert-s2,
  lmf-singlefoc_to_lmf-multifoc Cert-s1 M Cert1,
  lmf-singlefoc_to_lmf-multifoc Cert-s2 M Cert2.

all_kc Cert Cert' :-
  lmf-multifoc_to_lmf-singlefoc Cert _ Cert-s,
  all_kc Cert-s Cert-s',
  lmf-singlefoc_to_lmf-multifoc_all Cert-s' Cert'.

some_ke Cert X Cert' :-
  lmf-multifoc_to_lmf-singlefoc Cert M Cert-s,
  some_ke Cert-s X Cert-s',
  lmf-singlefoc_to_lmf-multifoc Cert-s' M Cert'.

