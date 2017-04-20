module tableaux.

% mv: in this version, we do not store relational atoms with a proper label
%  for extensions of K, it would be necessary to do it:
%  Idea: add a constructor
% type relind index -> index -> index.
%  where the two indexes refer to the formulas that introduced the two worlds

% The way it works is that the decide tree tells us the index of the formula to decide on but does not change the tree
% It is followed by a connective or initial rule, where we actually change the tree and update the index of the sub formulas
% Then we store it using the updated index
decide_ke (modtab-cert (dectree I D) M1 M2 M5 Bnd (state _ M3 M4)) I (modtab-cert (dectree I D) M1 M2 M5 Bnd (state [] M3 M4')) :-
    reduce_or_set_decide_bound M4 I (snum _) M4'.

% some indices correspond to a tactics language which is parsed by this expert
decide_ke (modtab-cert (dectree (modal MI I) D) M1 M2 M5 Bnd (state _ M3 M4)) I' Cert :-
  decide_ke (modtab-cert (dectree MI [dectree I D]) M1 M2 M5 Bnd (state [] M3 M4')) I' Cert.

% this fails if it doesnt find an entry with value greater than znumnum
reduce_or_set_decide_bound [decide-bound-entry I (snum B)| R] I (snum B) [decide-bound-entry I B| R]. % reduce if found
reduce_or_set_decide_bound [X|L] I B [X|L'] :- reduce_or_set_decide_bound L I B L'.

store_kc (modtab-cert DT M1 M2 M5 Bnd (state [H|T] M3 M4)) _ H (modtab-cert DT M1 M2 M5 Bnd (state T M3 [decide-bound-entry H Bnd | M4])).

release_ke C C.

% relation
initial_ke (modtab-cert (dectree relind []) _ _ _ _ _) relind.
initial_ke (modtab-cert (dectree I _) _ (init-map M2) _ _ _) O :- member (init-entry I O) M2.

% orNeg generated by the translation of the theorem
% Do not decompose the decide tree (special cases for the axioms - very ugly)
orNeg_kc (modtab-cert D M1 M2 M5 Bnd (state [S] M3 M4)) ((n (rel _ _) !-! _)) (modtab-cert D M1 M2 M5 Bnd (state [relind,S] M3 M4)) :- !. % can orNeg appear above andPos? I want andPos to reset the tree and set the leaf node index to relind
orNeg_kc (modtab-cert D M1 M2 M5 Bnd (state [S] M3 M4)) ((p (rel _ _) !-! _)) (modtab-cert D M1 M2 M5 Bnd (state [relind,S] M3 M4)) :- !. % can orNeg appear above andPos? I want andPos to reset the tree and set the leaf node index to relind
% since we never use again the decision tree. Check with Marco.
% this is used if orNeg is the main connective of the formula on which we decide
% (used to distinguish between orNeg coming from translation of box and real orNeg)
% Decompose the decide tree
orNeg_kc (modtab-cert (dectree I [D]) M1 M2 M5 Bnd (state [] M3 M4)) _ (modtab-cert D M1 M2 M5 Bnd (state [lind I, rind I] M3 M4)).
orNeg_kc (modtab-cert D M1 M2 M5 Bnd (state [S] M3 M4)) _ (modtab-cert D M1 M2 M5 Bnd (state [S] M3 M4)).

% Decompose the decide tree
andNeg_kc (modtab-cert (dectree I [D1,D2]) M1 M2 M5 Bnd (state [] M3 M4)) _
  (modtab-cert D1 M1 M2 M5 Bnd (state [lind I] M3 M4)) (modtab-cert D2 M1 M2 M5 Bnd (state [rind I] M3 M4)).

% generated only by the translation of the theorem
% we can reset the decision tree and index on the left branch since it does not contain any other connective and just
% tries to close the relation
% Does not decompose the decide tree
andPos_k (modtab-cert (dectree I D) M1 M2 M5 Bnd S) (_ &+& (p (rel _ _))) left-first
  (modtab-cert (dectree relind []) _ _ _ Bnd (state [] _ _)) (modtab-cert (dectree relind []) M1 M2 M5 Bnd S) :- !.
andPos_k (modtab-cert (dectree I D) M1 M2 M5 Bnd S) _ left-first
  (modtab-cert (dectree relind []) M1 M2 M5 Bnd (state [] _ _)) (modtab-cert (dectree I D) M1 M2 M5 Bnd S).

all_kc (modtab-cert (dectree I [S]) M1 M2 M5 Bnd (state [] M3 M4))
  (Eigen\ modtab-cert S M1 M2 M5 Bnd (state [lind I] [eigen-entry I Eigen|M3] M4)).
% for extensions of K, we will need to define also a case where the first list of S is not []

% real diamonds
some_ke (modtab-cert (dectree I [S]) (diabox-map M1) M2 M5 Bnd (state [] M3 M4)) Eigen
  (modtab-cert S (diabox-map M1) M2 M5 Bnd (state [bind I O] M3 M4)) :-
  (member (diabox-entry I O) M1, member (eigen-entry O Eigen)  M3).
% in case of axioms
% we need to decompose the dectree since the axiom-entry list contains only 1 value [O]
some_ke (modtab-cert (dectree I [S]) M1 M2 (axiom-map M5) Bnd (state _ M3 M4)) Eigen
  (modtab-cert S M1 M2 (axiom-map M5') Bnd (state [relind] M3 M4)) :-
  (memb_and_rest (axiom-entry I [O]) M5 M5', member (eigen-entry O Eigen)  M3).
% we do not decompose the dectree since the axiom-entry list contains more than 1 value [O,Q|Ls]
some_ke (modtab-cert (dectree I [S]) M1 M2 (axiom-map M5) Bnd (state _ M3 M4)) Eigen
  (modtab-cert (dectree I [S]) M1 M2 (axiom-map [axiom-entry I [Q|Ls] | M5']) Bnd (state [relind] M3 M4)) :-
  (memb_and_rest (axiom-entry I [O,Q|Ls]) M5 M5', member (eigen-entry O Eigen)  M3).

% for extensions of K, we will need to define also a case where the first list of S is not []
