module lmfs.

% mv: in this version, we do not store relational atoms with a proper label
%  for extensions of K, it would be necessary to do it:
%  Idea: add a constructor
% type relind index -> index -> index.
%  where the two indexes refer to the formulas that introduced the two worlds

% The way it works is that the decide tree tells us the index of the formula to decide on but does not change the tree
% It is followed by a connective or initial rule, where we actually change the tree and update the index of the sub formulas
% Then we store it using the updated index

decide_ke (lmfs-cert (dectree I D) M1 M2 Bnd (state _ M3 M4)) I (lmfs-cert (dectree I D) M1 M2 Bnd (state [] M3 M4')) :-
    reduce_or_set_decide_bound M4 I (snum _) M4'.

% this fails if it doesnt find an entry with value greater than znumnum
reduce_or_set_decide_bound [decide-bound-entry I (snum B)| R] I (snum B) [decide-bound-entry I B| R]. % reduce if found
reduce_or_set_decide_bound [X|L] I B [X|L'] :- reduce_or_set_decide_bound L I B L'.

store_kc (lmfs-cert DT M1 M2 Bnd (state [H|T] M3 M4)) _ H (lmfs-cert DT M1 M2 Bnd (state T M3 [decide-bound-entry H Bnd | M4])).

release_ke C C.

% relation
initial_ke (lmfs-cert (dectree relind []) _ _ _ _) relind.
initial_ke (lmfs-cert (dectree I _) _ (init-map M2) _ _) O :- member (init-entry I O) M2.

% since we never use again the decision tree. Check with Marco.
% this is used if orNeg is the main connective of the formula on which we decide
% (used to distinguish between orNeg coming from translation of box and real orNeg)
% Decompose the decide tree
orNeg_kc (lmfs-cert (dectree I [D]) M1 M2 Bnd (state [] M3 M4)) _ (lmfs-cert D M1 M2 Bnd (state [lind I, rind I] M3 M4)) :- !.
orNeg_kc (lmfs-cert D M1 M2 Bnd (state [S] M3 M4)) ((n (rel _ _) !-! _)) (lmfs-cert D M1 M2 Bnd (state [relind,S] M3 M4)) :- !. % can orNeg appear above andPos? I want andPos to reset the tree and set the leaf node index to relind
orNeg_kc (lmfs-cert D M1 M2 Bnd (state [S] M3 M4)) ((p (rel _ _) !-! _)) (lmfs-cert D M1 M2 Bnd (state [relind,S] M3 M4)) :- !. % can orNeg appear above andPos? I want andPos to reset the tree and set the leaf node index to relind
orNeg_kc (lmfs-cert D M1 M2 Bnd (state S M3 M4)) _ (lmfs-cert D M1 M2 Bnd (state S M3 M4)).

% Decompose the decide tree
andNeg_kc (lmfs-cert (dectree I [D1,D2]) M1 M2 Bnd (state [] M3 M4)) _
  (lmfs-cert D1 M1 M2 Bnd (state [lind I] M3 M4)) (lmfs-cert D2 M1 M2 Bnd (state [rind I] M3 M4)).

% generated only by the translation of the theorem
% we can reset the decision tree and index on the left branch since it does not contain any other connective and just
% tries to close the relation
% Does not decompose the decide tree
andPos_k (lmfs-cert (dectree I D) M1 M2 Bnd S) (_ &+& (p (rel _ _))) left-first
  (lmfs-cert (dectree relind []) _ _ _ (state [] _ _)) (lmfs-cert (dectree relind []) M1 M2 Bnd S) :- !.
andPos_k (lmfs-cert (dectree I D) M1 M2 Bnd S) _ left-first
  (lmfs-cert (dectree relind []) M1 M2 Bnd (state [] _ _)) (lmfs-cert (dectree I D) M1 M2 Bnd S).



all_kc (lmfs-cert (dectree I [S]) M1 M2 Bnd (state [] M3 M4))
  (Eigen\ lmfs-cert S M1 M2 Bnd (state [lind I] [eigen-entry I Eigen|M3] M4)) :-
  member (eigen-entry I _) M3, !, fail.
all_kc (lmfs-cert (dectree I [S]) M1 M2 Bnd (state [] M3 M4))
  (Eigen\ lmfs-cert S M1 M2 Bnd (state [lind I] [eigen-entry I Eigen|M3] M4)).

% for extensions of K, we will need to define also a case where the first list of S is not []

% real diamonds
some_ke (lmfs-cert (dectree I [S]) (diabox-map M1) M2 Bnd (state [] M3 M4)) Eigen
  (lmfs-cert S (diabox-map M1) M2 Bnd (state [bind I O] M3 M4)) :-
  (member (diabox-entry I O) M1, member (eigen-entry O Eigen)  M3).
% in case of axioms

% for extensions of K, we will need to define also a case where the first list of S is not []
