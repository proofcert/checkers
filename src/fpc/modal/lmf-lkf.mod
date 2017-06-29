module lmf-lkf.

% Translation between the fake calculus LMF to LKF. Is the base for other prfal translations.

decide_ke (mcert C prf Lbls _) (lblind LL I) (mcert C' prf Lbls LL) :- decidem_ke C I LL C'.

store_kc  (mcert C tns Lbls LL) _ relind (mcert C prf Lbls LL).
store_kc  (mcert C prf Lbls LL) F (lblind LL I) (mcert C' prf Lbls LL) :- storem_kc C I C'.

release_ke (mcert C prf Lbls LL) (mcert C' prf Lbls LL) :- releasem_ke C C'.

% relation
initial_ke (mcert _ tns _ _) relind.
initial_ke (mcert C prf _ Lbl) (lblind Lbl I) :- initialm_ke C I.

orNeg_kc (mcert C prf Lbls LL) F (mcert C' prf Lbls LL) :- orNegm_kc C C'.
orNeg_kc (mcert C tns Lbls LL) _ (mcert C tns Lbls LL).

andNeg_kc (mcert C prf Lbls LL) F (mcert C' prf Lbls LL) (mcert C'' prf Lbls LL) :- andNegm_kc C C' C''.

andPos_k (mcert C tns Lbls LL) _ S (mcert C' tns Lbls LL) (mcert C prf Lbls LL).

all_kc (mcert C prf Lbls _) (Eigen\ mcert (C' Eigen) tns [pr Eigen Lbl| Lbls] Lbl) :-
  boxm_kc C Lbl C'.

some_ke (mcert C prf Lbls _) Eigen (mcert C' tns Lbls T) :-
  diam_ke C T C', member (pr Eigen T) Lbls.
