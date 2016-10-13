module lmf-multifoc.

% mv: in this version, we do not store relational atoms with a proper label
%  for extensions of K, it would be necessary to do it:
%  Idea: add a constructor
% type relind index -> index -> index.
%  where the two indexes refer to the formulas that introduced the two worlds

% helpers

% translate without recursing
lmf-multifoc_to_lmf-singlefoc
  (lmf-multifoc-cert S (lmf-tree (lmf-multifoc-node M N) C))
  M
  (lmf-singlefoc-cert S (lmf-tree N C)).

lmf-singlefoc_to_lmf-multifoc
  (lmf-singlefoc-cert S (lmf-tree N C))
  M
  (lmf-multifoc-cert S (lmf-tree (lmf-multifoc-node M N) C)).



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

% when recursing on tree, we dont need to translate back
% the state tells us if we recurse or not
orNeg_kc (lmf-multifoc-cert (lmf-singlefoc-state [] M) T) Form Cert' :-
  lmf-multifoc_to_lmf-singlefoc (lmf-multifoc-cert (lmf-singlefoc-state [] M) T) _ Cert-s,
  orNeg_kc Cert-s Form Cert'.

% here we dont recurse
orNeg_kc Cert Form Cert' :-
  lmf-multifoc_to_lmf-singlefoc Cert M Cert-s,
  orNeg_kc Cert-s Form Cert-s',
  lmf-singlefoc_to_lmf-multifoc Cert-s' M Cert'.

% here we recurse
andNeg_kc (lmf-multifoc-cert (lmf-singlefoc-state [] M) T) Form Cert1 Cert2 :-
  lmf-multifoc_to_lmf-singlefoc (lmf-multifoc-cert (lmf-singlefoc-state [] M) T) _ Cert-s,
  andNeg_kc Cert-s Form Cert1 Cert2.

% here we dont recurse
andNeg_kc Cert Form Cert1 Cert2 :-
  lmf-multifoc_to_lmf-singlefoc Cert M Cert-s,
  andNeg_kc Cert-s Form Cert-s1 Cert-s2,
  lmf-singlefoc_to_lmf-multifoc Cert-s1 M Cert1,
  lmf-singlefoc_to_lmf-multifoc Cert-s2 M Cert2.

% here we dont recurse
andPos_ke Cert Form Cert1 Cert2 :-
  lmf-multifoc_to_lmf-singlefoc Cert M Cert-s,
  andPos_ke Cert-s Form Cert-s1 Cert-s2,
  lmf-singlefoc_to_lmf-multifoc Cert-s1 M Cert1,
  lmf-singlefoc_to_lmf-multifoc Cert-s2 M Cert2.

% here we recurse
all_kc Cert Cert' :-
  lmf-multifoc_to_lmf-singlefoc Cert M Cert-s,
  all_kc Cert-s Cert'.

% here we recurse
some_ke Cert X Cert' :-
  lmf-multifoc_to_lmf-singlefoc Cert M Cert-s,
  some_ke Cert-s X Cert'.

