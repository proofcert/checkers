module simpfit-tableaux.

% mv: in this version, we do not store relational atoms with a proper label
%  for extensions of K, it would be necessary to do it:
%  Idea: add a constructor 
% type relind index -> index -> index.
%  where the two indexes refer to the formulas that introduced the two worlds

% TYPE DECLARATION - JUST FOR REFERENCE
% type closure index -> index -> closure.
% type boxinfo index -> index -> boxinfo.
% type use index -> use.
% type simpfitcert int -> list index -> list closure -> list boxinfo -> list (pair index atm) -> list use -> cert.

decide_ke (simpfitcert F I C B E U) D (simpfitcert 1 [D] C B E U2) :- memb_and_rest (use D) U U2.
decide_ke (simpfitcert F I C B E U) none (simpfitcert 1 [none] C B E U). % used to decide on relational formulas; probably not necessary for K

store_kc (simpfitcert F I C B E U) (n (rel X Y)) none (simpfitcert 0 I C B E U) :- !. % in the case of relational atoms, we use none as the index
store_kc (simpfitcert F I C B E U) (p (rel X Y)) none (simpfitcert 0 I C B E U) :- !. % in the case of relational atoms, we use none as the index
store_kc (simpfitcert F [H|T] C B E U) (n A) H (simpfitcert 0 T C B E U) :- !. % in case of negative atoms, do not add the index to the list of usable ones
store_kc (simpfitcert F [H|T] C B E U) Form H (simpfitcert 0 T C B E [(use H)|U]). % general case: store the formula and add the index to the set of usable ones

release_ke C C.

initial_ke (simpfitcert F [I|T] C B E U) Compl :- member (closure I Compl) C. % close wrt to the corresponding index in the closure set
initial_ke (simpfitcert F [I|T] C B E U) none. % case for relational atoms

orNeg_kc (simpfitcert 1 [I] C B E U) Form (simpfitcert 0 [lind I, rind I] C B E U). % case when orNeg is the main connective of the formula on which we decide (used to distinguish between orNeg coming from translation of box and real orNeg)
orNeg_kc (simpfitcert 0 I C B E U) Form (simpfitcert 0 I C B E U). % this is used otherwise

andNeg_kc (simpfitcert 1 [I] C B E U) Form (simpfitcert 0 [lind I] C B E U) (simpfitcert 0 [rind I] C B E U). % case when andNeg is the main connective of the formula on which we decide (used to distinguish between orNeg coming from translation of box and real orNeg)
andNeg_kc (simpfitcert 0 I C B E U) Form (simpfitcert 0 I C B E U) (simpfitcert 0 I C B E U). % this is used otherwise

andPos_k (simpfitcert F I C B E U) Form left-first (simpfitcert 0 I C B E U) (simpfitcert 0 I C B E U). % andPos only comes from translation of a diamond

all_kc (simpfitcert F [I] C B E U) (Eigen\ simpfitcert 0 [lind I] C B [pr I Eigen|E] U). % also updates the set of eigenvariables

some_ke (simpfitcert F [I] C B E U) X (simpfitcert 0 [bind I O] C B2 E [(use I)|U]) :- member (pr O X) E, memb_and_rest (boxinfo I O) B B2. % uses the info in the boxinfo list and the proper eigenvariable