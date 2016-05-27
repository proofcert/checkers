module simpfit-tableaux.

% mv: in this version, we do not store relational atoms with a proper label
%  for extensions of K, it would be necessary to do it:
%  Idea: add a constructor 
% type relind index -> index -> index.
%  where the two indexes refer to the formulas that introduced the two worlds

% type closure index -> index -> closure.
% type boxinfo index -> index -> boxinfo.
% type used index -> used.
% type simpfitcert int -> list index -> list closure -> list boxinfo -> list (pair index atm) -> list used -> cert.

%decide_ke (simpfitcert F I C B E U) D (simpfitcert 1 [D] C B E U) :- member (closure D X) C. % literal case
decide_ke (simpfitcert F I C B E U) D (simpfitcert 1 [D] C B E [used D|U]) :- not (member (used D) U). % general case
%decide_ke (simpfitcert F I C B E U) (lind eind) (simpfitcert 1 [(lind eind)] C B E [used (lind eind)|U]).
%decide_ke (simpfitcert F I C B E U) D (simpfitcert 1 [D] C B E U) :- member (boxinfo D X) B. % box case (remember to put every box and literal in the used list when you encounter it)

%:- not (member (used D) U)

% decide_ke (fitcert L (dectree I O D) M) I (fitcert [] (dectree I O D) M).

store_kc (simpfitcert F I C B E U) (n (rel X Y)) none (simpfitcert 0 I C B E U) :- !. % in the case of relational atoms, we use none as the index
store_kc (simpfitcert F I C B E U) (p (rel X Y)) none (simpfitcert 0 I C B E U) :- !. % in the case of relational atoms, we use none as the index
store_kc (simpfitcert F [H|T] C B E U) Form H (simpfitcert 0 T C B E U).

% store_kc (simpfitcert F I C B E U) (n (rel X Y)) none (simpfitcert 0 I C B E [used D|U]) :- !. % in the case of relational atoms, we use none as the index
% store_kc C (n (rel X Y)) none C :- !. % in the case of relational atoms, we use none as the index
% store_kc C (p (rel X Y)) none C :- !. % in the case of relational atoms, we use none as the index
% store_kc (fitcert [H|T] D M) Form H (fitcert T D M).

release_ke C C.

initial_ke (simpfitcert F [I|T] C B E U) Compl :- member (closure I Compl) C. % reminder: remove I from Used
initial_ke (simpfitcert F [I|T] C B E U) none. % case for relational atoms
% initial_ke (fitcert L (dectree I O D) M) O.
% do not we need init for relations?

orNeg_kc (simpfitcert 1 [I] C B E U) Form (simpfitcert 0 [lind I, rind I] C B E U). % this is used if orNeg is the main connective of the formula on which we decide (used to distinguish between orNeg coming from translation of box and real orNeg)
orNeg_kc (simpfitcert 0 I C B E U) Form (simpfitcert 0 I C B E U). % this is used otherwise
% orNeg_kc (fitcert [] (dectree I O [H|T]) M) Form (fitcert [lind I, rind I] H M). % this is used if orNeg is the main connective of the formula on which we decide (used to distinguish between orNeg coming from translation of box and real orNeg)
% orNeg_kc (fitcert [E|L] D M) Form (fitcert [E|L] D M). % this is used otherwise

andNeg_kc (simpfitcert 1 [I] C B E U) Form (simpfitcert 0 [lind I] C B E U) (simpfitcert 0 [rind I] C B E U).
andNeg_kc (simpfitcert 0 I C B E U) Form (simpfitcert 0 I C B E U) (simpfitcert 0 I C B E U).
% andNeg_kc (fitcert [] (dectree I O [H,G|T]) M) Form (fitcert [lind I] H M) (fitcert [rind I] G M).
% andNeg_kc (fitcert [E|L] D M) Form (fitcert [E|L] D M) (fitcert [E|L] D M).

andPos_k (simpfitcert F I C B E U) Form left-first (simpfitcert 0 I C B E U) (simpfitcert 0 I C B E U).
% andPos_k (fitcert L (dectree I O T) M) Form left-first (fitcert L (dectree I none T) M) (fitcert L (dectree I O T) M).

all_kc (simpfitcert F [I] C B E U) (Eigen\ simpfitcert 0 [lind I] C B [pr I Eigen|E] U).
% all_kc (fitcert [] (dectree I O [H|T]) M) (Eigen\ fitcert [lind I] H [pr I Eigen|M]).
% for extensions of K, we will need to define also a case where the first list is not []

some_ke (simpfitcert F [I] C B E U) X (simpfitcert 0 [bind I O] C B2 E U2) :- member (pr O X) E, memb_and_rest (boxinfo I O) B B2, memb_and_rest (used I) U U2. %
% some_ke (fitcert [] (dectree I O [H|T]) M) X (fitcert [bind I O] H M) :- member (pr O X) M. %
% for extensions of K, we will need to define also a case where the first list is not []