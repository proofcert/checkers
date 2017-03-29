module fittings-tableaux.

% mv: in this version, we do not store relational atoms with a proper label
%  for extensions of K, it would be necessary to do it:
%  Idea: add a constructor
% type relind index -> index -> index.
%  where the two indexes refer to the formulas that introduced the two worlds

decide_ke (fitcert L (dectree I O D) M) I (fitcert [] (dectree I O D) M).

store_kc C (n (rel X Y)) none C :- !. % in the case of relational atoms, we use none as the index
store_kc C (p (rel X Y)) none C :- !. % in the case of relational atoms, we use none as the index
%store_kc (fitcert [H|T] (dectree I O D) M) (d+ A) H (fitcert T (dectree H none ((dectree I O D) :: nil)) M) :- isNegAtm (A), !. % special case: used for
%storing delayed negative atoms (necessary in the case when we delay also atoms)
%store_kc (fitcert [] (dectree I O [H|T]) M) Form I (fitcert [] H M). % special case: used for storing negative atoms (necessary in the case when we delay also
%atoms)
store_kc (fitcert [H|T] D M) Form H (fitcert T D M). % general case

release_ke C C.

initial_ke (fitcert L (dectree I O D) M) O.

orNeg_kc (fitcert [] (dectree I O [H|T]) M) Form (fitcert [lind I, rind I] H M). % this is used if orNeg is the main connective of the formula on which we decide (used to distinguish between orNeg coming from translation of box and real orNeg)
orNeg_kc (fitcert [E|L] D M) Form (fitcert [E|L] D M). % this is used otherwise

andNeg_kc (fitcert [] (dectree I O [H,G|T]) M) Form (fitcert [lind I] H M) (fitcert [rind I] G M).
andNeg_kc (fitcert [E|L] D M) Form (fitcert [E|L] D M) (fitcert [E|L] D M).

andPos_k (fitcert L (dectree I O T) M) Form left-first (fitcert L (dectree I none T) M) (fitcert L (dectree I O T) M).

all_kc (fitcert [] (dectree I O [H|T]) M) (Eigen\ fitcert [lind I] H [pr I Eigen|M]).
% for extensions of K, we will need to define also a case where the first list is not []

some_ke (fitcert [] (dectree I O [H|T]) M) X (fitcert [bind I O] H M) :- member (pr O X) M. %
% for extensions of K, we will need to define also a case where the first list is not []

