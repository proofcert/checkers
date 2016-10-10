module lmf-singlefoc.

% mv: in this version, we do not store relational atoms with a proper label
%  for extensions of K, it would be necessary to do it:
%  Idea: add a constructor 
% type relind index -> index -> index.
%  where the two indexes refer to the formulas that introduced the two worlds

decide_ke (singlefoc-cert L (singlefoc-evidence I O D) M) I (singlefoc-cert [] (singlefoc-evidence I O D) M).

store_kc C (n (rel X Y)) none C :- !. % in the case of relational atoms, we use none as the index
store_kc C (p (rel X Y)) none C :- !. % in the case of relational atoms, we use none as the index
store_kc (singlefoc-cert [H|T] (singlefoc-evidence I O D) M) (d+ A) H (singlefoc-cert T (singlefoc-evidence H none ((singlefoc-evidence I O D) :: nil)) M) :- isNegAtm (A), !. % special case: used for storing delayed negative atoms (necessary in the case when we delay also atoms)
store_kc (singlefoc-cert [] (singlefoc-evidence I O [H|T]) M) Form I (singlefoc-cert [] H M). % special case: used for storing negative atoms (necessary in the case when we delay also atoms)
store_kc (singlefoc-cert [H|T] D M) Form H (singlefoc-cert T D M). % general case

release_ke C C.

initial_ke (singlefoc-cert L (singlefoc-evidence I O D) M) O.

orNeg_kc (singlefoc-cert [] (singlefoc-evidence I O [H|T]) M) Form (singlefoc-cert [lind I, rind I] H M). % this is used if orNeg is the main connective of the formula on which we decide (used to distinguish between orNeg coming from translation of box and real orNeg)
orNeg_kc (singlefoc-cert [E|L] D M) Form (singlefoc-cert [E|L] D M). % this is used otherwise

andNeg_kc (singlefoc-cert [] (singlefoc-evidence I O [H,G|T]) M) Form (singlefoc-cert [lind I] H M) (singlefoc-cert [rind I] G M).
andNeg_kc (singlefoc-cert [E|L] D M) Form (singlefoc-cert [E|L] D M) (singlefoc-cert [E|L] D M).

andPos_k (singlefoc-cert L (singlefoc-evidence I O T) M) Form left-first (singlefoc-cert L (singlefoc-evidence I none T) M) (singlefoc-cert L (singlefoc-evidence I O T) M).

all_kc (singlefoc-cert [] (singlefoc-evidence I O [H|T]) M) (Eigen\ singlefoc-cert [lind I] H [pr I Eigen|M]).
% for extensions of K, we will need to define also a case where the first list is not []

some_ke (singlefoc-cert [] (singlefoc-evidence I O [H|T]) M) X (singlefoc-cert [diaind I O] H M) :- member (pr O X) M. %
% for extensions of K, we will need to define also a case where the first list is not []

