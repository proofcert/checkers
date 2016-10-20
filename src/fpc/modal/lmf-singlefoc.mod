module lmf-singlefoc.

% mv: in this version, we do not store relational atoms with a proper label
%  for extensions of K, it would be necessary to do it:
%  Idea: add a constructor
% type relind index -> index -> index.
%  where the two indexes refer to the formulas that introduced the two worlds

decide_ke
  (lmf-singlefoc-cert (lmf-singlefoc-state _ M) (lmf-tree (lmf-singlefoc-node I O) D))
  I
  (lmf-singlefoc-cert (lmf-singlefoc-state [] M) (lmf-tree (lmf-singlefoc-node I O) D)).

% in the case of relational atoms, we use none as the index
store_kc C (n (rel X Y)) none C
  :- !.
store_kc C (p (rel X Y)) none C
  :- !.

% special case: used for storing delayed negative atoms (necessary in the case when we delay also atoms)
%store_kc
%  (lmf-singlefoc-cert (lmf-singlefoc-state [H|T] M) D)
%  (d+ A)
%  H
%  (lmf-singlefoc-cert
%    (lmf-singlefoc-state T M)
%    (lmf-tree (lmf-singlefoc-node H none) [(lmf-tree (lmf-singlefoc-node I O) [D])]))
%      :- isNegAtm (A), !.

% special case: used for storing negative atoms (necessary in the case when we delay also atoms)
store_kc
  (lmf-singlefoc-cert (lmf-singlefoc-state [] M) (lmf-tree (lmf-singlefoc-node I O) [H]))
  Form
  I
  (lmf-singlefoc-cert (lmf-singlefoc-state [] M) H).

% general case
store_kc
  (lmf-singlefoc-cert (lmf-singlefoc-state [H|T] M) D)
  Form
  H
  (lmf-singlefoc-cert (lmf-singlefoc-state T M) D).

release_ke C C.

initial_ke
  (lmf-singlefoc-cert S (lmf-tree (lmf-singlefoc-node _ O) _)) O.

% this is used if orNeg is the main connective of the formula on which we decide (used to distinguish between orNeg coming from translation of box and real orNeg)
orNeg_kc
  (lmf-singlefoc-cert (lmf-singlefoc-state [] M) (lmf-tree (lmf-singlefoc-node I O) [H|T]))
  _
  (lmf-singlefoc-cert (lmf-singlefoc-state [lind I, rind I] M) H).

% this is used otherwise
orNeg_kc C _ C.

andNeg_kc
  (lmf-singlefoc-cert (lmf-singlefoc-state [] M) (lmf-tree (lmf-singlefoc-node I O) [H,G|T]))
  _
  (lmf-singlefoc-cert (lmf-singlefoc-state [lind I] M) H)
  (lmf-singlefoc-cert (lmf-singlefoc-state [rind I] M) G).

andNeg_kc A _ A A.

andPos_k
  (lmf-singlefoc-cert S (lmf-tree (lmf-singlefoc-node I O) T))
  _
  left-first
  (lmf-singlefoc-cert S (lmf-tree (lmf-singlefoc-node I none) T))
  (lmf-singlefoc-cert S (lmf-tree (lmf-singlefoc-node I O) T)).

% for extensions of K, we will need to define also a case where the first list is not []
all_kc
  (lmf-singlefoc-cert (lmf-singlefoc-state [] M) (lmf-tree (lmf-singlefoc-node I O) [H|T]))
  (Eigen\ lmf-singlefoc-cert (lmf-singlefoc-state [lind I] [pr I Eigen|M]) H).

% for extensions of K, we will need to define also a case where the first list is not []
some_ke
  (lmf-singlefoc-cert (lmf-singlefoc-state [] M) (lmf-tree (lmf-singlefoc-node I O) [H|T]))
  X
  (lmf-singlefoc-cert (lmf-singlefoc-state [diaind I O] M) H)
     :- member (pr O X) M.

