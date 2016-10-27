module lmf-star.

accumulate lmf-multifoc.
accumulate debug.

% mv: in this version, we do not store relational atoms with a proper label
%  for extensions of K, it would be necessary to do it:
%  Idea: add a constructor
% type relind index -> index -> index.
%  where the two indexes refer to the formulas that introduced the two worlds

% helpers

lmf-star_to_lmf-multifoc
  (lmf-star-cert S (lmf-multifoc-cert (lmf-singlefoc-cert S1 (lmf-tree (lmf-star-node H F N) C))))
  S H F
  (lmf-multifoc-cert (lmf-singlefoc-cert S1 (lmf-tree N C))).

lmf-multifoc_to_lmf-star
  (lmf-multifoc-cert (lmf-singlefoc-cert S1 (lmf-tree (lmf-multifoc-node M N) C)))
  S H F
  (lmf-star-cert S (lmf-multifoc-cert (lmf-singlefoc-cert S1 (lmf-tree (lmf-star-node H F (lmf-multifoc-node M N)) C)))).

lmf-multifoc_to_lmf-star
  (lmf-multifoc-cert (lmf-singlefoc-cert S1 (lmf-tree (lmf-star-node H F N) C)))
  S _ _
  (lmf-star-cert S (lmf-multifoc-cert (lmf-singlefoc-cert S1 (lmf-tree (lmf-star-node H F N) C)))).

lmf-multifoc_to_lmf-star_all
  Cert
  S
  (w\ lmf-star-cert S (Cert w)).

% The map in the state is between labels and the present of formulas
% This map is managed by all rules and is required for decide
% everytime a new formula is created (by logical rules) we need to add to the map its index
% and the present of its parent, unless it is diamond or box which change the present

% NOTE: the index to map is the index of the children. I.e. in the or rules, we map the index
% of the children to the world mapped to the or

% decide changes as follows over the decide of single-foc (in multi-foc we do nothing)
% A formula can be decided on only if its index is mapped to a world which is allowed by H
% It also uses the future in the node to set the future in the state which will be used by a later dia
decide_ke Cert L Cert' :-
  lmf-star_to_lmf-multifoc Cert S H F Cert-s,
  decide_ke Cert-s L Cert-s',
  lmf-multifoc_to_lmf-star Cert-s' S H F Cert'.

store_kc Cert L B Cert' :-
  lmf-star_to_lmf-multifoc Cert S H F Cert-s,
  store_kc Cert-s L B Cert-s',
  lmf-multifoc_to_lmf-star Cert-s' S H F Cert'.

release_ke Cert Cert.

initial_ke Cert O :-
  lmf-star_to_lmf-multifoc Cert _ _ _ Cert-s,
  initial_ke Cert-s O.

% needs to update the map in the state to map the index to the value mapped to the index of the parent (first is zero)
orNeg_kc Cert Form Cert' :-
  lmf-star_to_lmf-multifoc Cert S H F Cert-s,
  orNeg_kc Cert-s Form Cert-s',
  lmf-multifoc_to_lmf-star Cert-s' S H F Cert'.

% needs to update the map in the state to map the index to the value mapped to the index of the parent (first is zero)
andNeg_kc Cert Form Cert1 Cert2 :-
  lmf-star_to_lmf-multifoc Cert S H F Cert-s,
  andNeg_kc Cert-s Form Cert-s1 Cert-s2,
  lmf-multifoc_to_lmf-star Cert-s1 S H F Cert1,
  lmf-multifoc_to_lmf-star Cert-s2 S H F Cert2.

% needs to update the map in the state to map the index to the value mapped to the index of the parent (first is zero)
andPos_k Cert Form Str Cert1 Cert2 :-
  lmf-star_to_lmf-multifoc Cert S H F Cert-s,
  andPos_k Cert-s Form Str Cert-s1 Cert-s2,
  lmf-multifoc_to_lmf-star Cert-s1 S H F Cert1,
  lmf-multifoc_to_lmf-star Cert-s2 S H F Cert2.

% needs to update the map in the state to map the index of the child to the index of the father (box)
all_kc Cert Cert' :-
  lmf-star_to_lmf-multifoc Cert S _ _ Cert-s,
  all_kc Cert-s Cert-s',
  lmf-multifoc_to_lmf-star_all Cert-s' S Cert'.

% needs to update the map in the state to map the index of the child to the box component of the
% index of the parent (parent diamonds have dia(ind,box-ind))
% checks that the future in the state is equal to the future in the node
some_ke Cert X Cert' :-
  lmf-star_to_lmf-multifoc Cert S H F Cert-s,
  some_ke Cert-s X Cert-s',
  lmf-multifoc_to_lmf-star Cert-s' S H F Cert'.

