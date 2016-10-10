module lmf-star.

% mv: in this version, we do not store relational atoms with a proper label
%  for extensions of K, it would be necessary to do it:
%  Idea: add a constructor 
% type relind index -> index -> index.
%  where the two indexes refer to the formulas that introduced the two worlds

decide_ke (star-cert L (star-evidence ([Ind Opt Present|Rest]) Evidence) EigenList) Ind3 (star-cert L2 (star-evidence ([Ind2 Opt2 Present|Rest]) Evidence) EigenList2) :- 
  decide_ke (lmf-cert L (lmf-evidence Ind Opt LMFEvidence) EigenList) Ind3 (lmf-cert L2 (lmf-evidence Ind2 Opt2 LMFEvidence) EigenList2).
%decide_ke (lmf-cert L (lmf-evidence I O D) M) I (lmf-cert [] (lmf-evidence I O D) M).

store_kc C (n (rel X Y)) none C :- !. % in the case of relational atoms, we use none as the index
store_kc C (p (rel X Y)) none C :- !. % in the case of relational atoms, we use none as the index
store_kc (lmf-cert [H|T] (lmf-evidence I O D) M) (d+ A) H (lmf-cert T (lmf-evidence H none ((lmf-evidence I O D) :: nil)) M) :- isNegAtm (A), !. % special case: used for storing delayed negative atoms (necessary in the case when we delay also atoms)
store_kc (lmf-cert [] (lmf-evidence I O [H|T]) M) Form I (lmf-cert [] H M). % special case: used for storing negative atoms (necessary in the case when we delay also atoms)
store_kc (lmf-cert [H|T] D M) Form H (lmf-cert T D M). % general case

release_ke C C.

initial_ke (lmf-cert L (lmf-evidence I O D) M) O.

orNeg_kc (lmf-cert [] (lmf-evidence I O [H|T]) M) Form (lmf-cert [lind I, rind I] H M). % this is used if orNeg is the main connective of the formula on which we decide (used to distinguish between orNeg coming from translation of box and real orNeg)
orNeg_kc (lmf-cert [E|L] D M) Form (lmf-cert [E|L] D M). % this is used otherwise

andNeg_kc (lmf-cert [] (lmf-evidence I O [H,G|T]) M) Form (lmf-cert [lind I] H M) (lmf-cert [rind I] G M).
andNeg_kc (lmf-cert [E|L] D M) Form (lmf-cert [E|L] D M) (lmf-cert [E|L] D M).

andPos_k (lmf-cert L (lmf-evidence I O T) M) Form left-first (lmf-cert L (lmf-evidence I none T) M) (lmf-cert L (lmf-evidence I O T) M).

all_kc (lmf-cert [] (lmf-evidence I O [H|T]) M) (Eigen\ lmf-cert [lind I] H [pr I Eigen|M]).
% for extensions of K, we will need to define also a case where the first list is not []

some_ke (lmf-cert [] (lmf-evidence I O [H|T]) M) X (lmf-cert [diaind I O] H M) :- member (pr O X) M. %
% for extensions of K, we will need to define also a case where the first list is not []

