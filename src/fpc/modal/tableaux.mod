module tableaux.

% mv: in this version, we do not store relational atoms with a proper label
%  for extensions of K, it would be necessary to do it:
%  Idea: add a constructor
% type relind index -> index -> index.
%  where the two indexes refer to the formulas that introduced the two worlds

% The way it works is that the decide tree tells us the index of the formula to decide on but does not change the tree
% It is followed by a connective or initial rule, where we actually change the tree and update the index of the sub formulas
% Then we store it using the updated index

decide_ke (modtab-cert (dectree I D) M1 M2 (state _ M3)) I (modtab-cert (dectree I D) M1 M2 (state [] M3)).

store_kc C (n (rel X Y)) relind C :- !. % in the case of relational atoms, we use none as the index
store_kc C (p (rel X Y)) relind C :- !. % in the case of relational atoms, we use none as the index
% special case: used for storing delayed negative atoms (necessary in the case when we delay also atoms)
<<<<<<< HEAD
store_kc (modtab-cert DT M1 M2 (state [H|T] M3)) (d+ A) H (modtab-cert (dectree H [DT]) M1 M2 (state T M3)) :- isNegAtm (A).
=======
store_kc (modtab-cert DT M1 M2 (state [H|T] M3)) (d+ A) H (modtab-cert (dectree H [DT]) M1 M2 (state T M3)) :- isNegAtm (A), !.
>>>>>>> gandalf2017
% special case: used for storing negative atoms (necessary in the case when we delay also atoms)
store_kc (modtab-cert (dectree I [H]) M1 M2 (state [] M3)) _ I (modtab-cert H M1 M2 (state [] M3)).
store_kc (modtab-cert DT M1 M2 (state [H|T] M3)) _ H (modtab-cert DT M1 M2 (state T M3)). % general case

release_ke C C.

% relation
initial_ke (modtab-cert (dectree relind []) _ _ _) relind.
initial_ke (modtab-cert (dectree I _) _ (init-map M2) _) O :- get-init-index I I', member (init-entry I' O) M2.

% this is used if orNeg is the main connective of the formula on which we decide (used to distinguish between orNeg coming from translation of box and real orNeg)
<<<<<<< HEAD
orNeg_kc (modtab-cert (dectree I [D]) M1 M2 (state [] M3)) _ (modtab-cert D M1 M2 (state [lind I, rind I] M3)).
% orNeg generated by the translation of the theorem
orNeg_kc C _ C. % can orNeg appear above andPos? I want andPos to reset the tree and set the leaf node index to relind
% since we never use again the decision tree. Check with Marco.

andNeg_kc (modtab-cert (dectree I [D1,D2]) M1 M2 (state [] M3)) _
  (modtab-cert D1 M1 M2 (state [lind I] M3)) (modtab-cert D2 M1 M2 (state [rind I] M3)).

% generated only by the translation of the theorem
% we can reset the decision tree and index on the left branch since it does not contain any other connective and just
% tries to close the relation
andPos_k (modtab-cert (dectree I D) M1 M2 S) _ left-first
  (modtab-cert (dectree relind []) _ _ _) (modtab-cert (dectree I D) M1 M2 S).

all_kc (modtab-cert (dectree I [S]) M1 M2 (state [] M3))
  (Eigen\ modtab-cert S M1 M2 (state [lind I] [eigen-entry I Eigen|M3])).
% for extensions of K, we will need to define also a case where the first list of S is not []

some_ke (modtab-cert (dectree I [S]) (diabox-map M1) M2 (state [] M3)) Eigen
  (modtab-cert S (diabox-map M1) M2 (state [bind I O] M3)) :-
    get-dia-index I I', member (diabox-entry I' O) M1, member (eigen-entry O Eigen)  M3.
% for extensions of K, we will need to define also a case where the first list of S is not []


get-dia-index I (dia-index I).
get-init-index I (init-index I).

Too much non determinism in store and in orNeg and maybe also in relind
=======
orNeg_kc (modtab-cert (dectree I [D]) M1 M2 (state [] M3)) _ (modtab-cert D M1 M2 (state [lind I, rind I] M3)) :- !.
% orNeg generated by the translation of the theorem
orNeg_kc C _ C. % can orNeg appear above andPos? I want andPos to reset the tree and set the leaf node index to relind
% since we never use again the decision tree. Check with Marco.

andNeg_kc (modtab-cert (dectree I [D1,D2]) M1 M2 (state [] M3)) _
  (modtab-cert D1 M1 M2 (state [lind I] M3)) (modtab-cert D2 M1 M2 (state [rind I] M3)) :- !.

% generated only by the translation of the theorem
% we can reset the decision tree and index on the left branch since it does not contain any other connective and just
% tries to close the relation
andPos_k (modtab-cert (dectree I D) M1 M2 S) _ left-first
  (modtab-cert (dectree relind []) _ _ _) (modtab-cert (dectree I D) M1 M2 S).

all_kc (modtab-cert (dectree I [S]) M1 M2 (state [] M3))
  (Eigen\ modtab-cert S M1 M2 (state [lind I] [eigen-entry I Eigen|M3])).
% for extensions of K, we will need to define also a case where the first list of S is not []

some_ke (modtab-cert (dectree I [S]) (diabox-map M1) M2 (state [] M3)) Eigen
  (modtab-cert S (diabox-map M1) M2 (state [bind I O] M3)) :-
    get-dia-index I I', member (diabox-entry I' O) M1, member (eigen-entry O Eigen)  M3.
% for extensions of K, we will need to define also a case where the first list of S is not []


get-dia-index I (dia-index I).
get-init-index I (init-index I).
>>>>>>> gandalf2017
