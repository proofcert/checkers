module lmf-star.

accumulate lmf-multifoc.
accumulate debug.
accumulate lists.

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
  (lmf-multifoc-cert (lmf-singlefoc-cert S1 (lmf-tree N C)))
  S _ _
  (lmf-star-cert S (lmf-multifoc-cert (lmf-singlefoc-cert S1 (lmf-tree N C)))).

lmf-multifoc_to_lmf-star_all
  Cert
  S
  (w\ lmf-star-cert S (Cert w)).

% extract all values in the different node types
% NH new history
% NF new future
% M multifocus index
% I index
% IO optional index
obtain_all_star_node_vals
(lmf-star-cert (lmf-star-state H F Map) (lmf-multifoc-cert (lmf-singlefoc-cert S1 (lmf-tree
  (lmf-star-node NH NF
    (lmf-multifoc-node M
      (lmf-singlefoc-node I IO))) C))))
H F Map NH NF M I IO.
obtain_all_star_node_vals_all
(w\ lmf-star-cert (lmf-star-state H F Map) (lmf-multifoc-cert (lmf-singlefoc-cert S1 (lmf-tree
  (lmf-star-node NH NF
    (lmf-multifoc-node M
      (lmf-singlefoc-node I IO))) C))))
H F Map NH NF M I IO.

obtain_value_in_map [(pr I V)|_] I V.
obtain_value_in_map [_|L] I V :- obtain_value_in_map L I V.

% the first node does not have parent and is already mapped (it is the root)
add_value_to_map_in_state (lmf-star-state H F Map) V I (lmf-star-state H F [(pr I V)|Map]).

% replace the state in the cert
change_state (lmf-star-cert _ C) S (lmf-star-cert S C).

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
  % we first obtain the index of the node
(obtain_all_star_node_vals Cert H F Map NH NF M I OI),
  % we now check the world against H
(obtain_value_in_map Map I V),
(member V H),
(lmf-star_to_lmf-multifoc Cert S NH NF Cert-s),
(decide_ke Cert-s L Cert-s'),
  % we reset the future to the value in the node
  % mv 03/11/16: I changed this because I want that history and future get updated in the new state
  % I don't understand exactly the way you were using lmf-multifoc_to_lmf-star
(lmf-multifoc_to_lmf-star Cert-s' (lmf-star-state NH NF Map) NH NF Cert'). 

% does nothing?
store_kc Cert L B Cert' :-
  lmf-star_to_lmf-multifoc Cert S H F Cert-s,
  store_kc Cert-s L B Cert-s',
  lmf-multifoc_to_lmf-star Cert-s' S H F Cert'.

release_ke Cert Cert.

initial_ke Cert O :-
  lmf-star_to_lmf-multifoc Cert _ _ _ Cert-s,
  initial_ke Cert-s O.

% does not update the state if it is an OR coming from the translation of a Box
% the check is on the fact that the next index I is not changed by the lower layers
% seems to work but there might be better solutions
orNeg_kc Cert Form Cert' :-
(lmf-star_to_lmf-multifoc Cert S H F Cert-s),
(orNeg_kc Cert-s Form Cert-s'),
(lmf-multifoc_to_lmf-star Cert-s' S H F Cert'),
(obtain_all_star_node_vals Cert _ _ Map _ _ _ I _),
(obtain_all_star_node_vals Cert' _ _ Map' _ _ _ I _),
(obtain_value_in_map Map I V), 
!.  
  
% needs to update the map in the state to map the index to the value mapped to the index of the parent (first is zero)
orNeg_kc Cert Form Cert-r :-
(lmf-star_to_lmf-multifoc Cert S H F Cert-s),
(orNeg_kc Cert-s Form Cert-s'),
(lmf-multifoc_to_lmf-star Cert-s' S H F Cert'),
(obtain_all_star_node_vals Cert _ _ Map _ _ _ I _),
(obtain_value_in_map Map I V),
  % adding child to map to the same value as parent
(add_value_to_map_in_state S V (lind I) S'),
(add_value_to_map_in_state S' V (rind I) S''),
  % state is changed
(change_state Cert' S'' Cert-r).

% needs to update the map in the state to map the index to the value mapped to the index of the parent (first is zero)
andNeg_kc Cert Form Cert1-r Cert2-r :-
 (lmf-star_to_lmf-multifoc Cert S H F Cert-s),
 (andNeg_kc Cert-s Form Cert-s1 Cert-s2),
 (lmf-multifoc_to_lmf-star Cert-s1 S H F Cert1),
  (lmf-multifoc_to_lmf-star Cert-s2 S H F Cert2),
  (obtain_all_star_node_vals Cert H F Map NH NF M I OI),
  (obtain_value_in_map Map I V),
  (obtain_all_star_node_vals Cert1 H1 F1 Map1 NH1 NF1 M1 I1 OI1),
  (obtain_all_star_node_vals Cert2 H2 F2 Map2 NH2 NF2 M2 I2 OI2),
  % adding child to map to the same value as parent
  (add_value_to_map_in_state S1 V I1 S1b), % strange that we have S1 twice
  (add_value_to_map_in_state S2 V I2 S2b), % strange that we have S2 twice
  % state is changed
  (change_state Cert1 S1b Cert1-r),
  (change_state Cert2 S2b Cert2-r).

% previous version: (add_value_to_map_in_state S1 V I1 S1), % strange that we have S1 twice
% previous version: (add_value_to_map_in_state S2 V I2 S2), % strange that we have S2 twice
  
  

% Does not need to update the map in the state since this only comes from the translation of a Diamond
andPos_k Cert Form Str Cert1 Cert2 :-
  (lmf-star_to_lmf-multifoc Cert S H F Cert-s),
  (andPos_k Cert-s Form Str Cert-s1 Cert-s2),
  (lmf-multifoc_to_lmf-star Cert-s1 S H F Cert1),
  (lmf-multifoc_to_lmf-star Cert-s2 S H F Cert2).
  
  % PREVIOUS VERSION
% needs to update the map in the state to map the index to the value mapped to the index of the parent (first is zero)
%andPos_k Cert Form Str Cert1-r Cert2-r :-
%  (lmf-star_to_lmf-multifoc Cert S H F Cert-s),
%  (andPos_k Cert-s Form Str Cert-s1 Cert-s2),
%  (obtain_all_star_node_vals Cert H F Map NH NF M I OI),
%  (lmf-multifoc_to_lmf-star Cert-s1 S1 H F Cert1),
%  (lmf-multifoc_to_lmf-star Cert-s2 S2 H F Cert2),
%  (obtain_all_star_node_vals Cert H F Map NH NF M I OI),
%  (obtain_value_in_map Map I V),
%  (obtain_all_star_node_vals Cert1 H1 F1 Map1 NH1 NF1 M1 I1 OI1),
%  (obtain_all_star_node_vals Cert2 H2 F2 Map2 NH2 NF2 M2 I2 OI2),
  % adding child to map to the same value as parent
%  (add_value_to_map_in_state S1 V I1 S1),
%  (add_value_to_map_in_state S2 V I2 S2),
  % state is changed
%  (change_state Cert1 S1 Cert1-r),
%  (change_state Cert2 S2 Cert2-r).

% needs to update the map in the state to map the index of the child to the index of the father (box)
all_kc Cert Cert' :-
  lmf-star_to_lmf-multifoc Cert S _ _ Cert-s,
  all_kc Cert-s Cert-s',
  obtain_all_star_node_vals Cert H F Map NH NF M I OI,
  % we cannot apply a relation unifying functions (Cert-s is a function)
  % spy "obtain " (obtain_all_multi_node_vals_all Cert-s' M' I' OI'),
  % ugly fix - we know the child index I' is lind(I)    
 I' = I,
  % adding child to map to its own index (we prefer to use the child instead of the father as an index in order to avoid clashes with the index root in case of 
  % a box-formula placed at the root position)
  add_value_to_map_in_state S I' I' S',
  % state is changed
  lmf-multifoc_to_lmf-star_all Cert-s' S' Cert'.

% needs to update the map in the state to map the index of the child to the box component of the
% index of the parent (parent diamonds have dia(ind,box-ind))---mv: not sure this is the case
% checks that the future in the state is equal to the future in the node
some_ke Cert X Cert'-r :-
(lmf-star_to_lmf-multifoc Cert S H F Cert-s),
(  some_ke Cert-s X Cert-s'),
(  lmf-multifoc_to_lmf-star Cert-s' S' H F Cert'),
  % checking that the future in the state is equal to the future in the node
(  obtain_all_star_node_vals Cert H F Map NH F M I OI),
(  obtain_all_star_node_vals Cert' H' F' Map' NH' F' M' I' OI'),
  % adding child to map to the box component of the parent (mv: changed S' into S1)
(  add_value_to_map_in_state S (OI) (diaind I OI) S1),
  % state is changed (mv: changed S' into S1)
(  change_state Cert' S1 Cert'-r).

% previous version: (  obtain_all_star_node_vals Cert H F Map NH F M (diaind I BI) OI),
% previous version: (  add_value_to_map_in_state S BI I' S'),