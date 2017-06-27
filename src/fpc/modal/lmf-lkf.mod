module lmf-lkf.

% Translation between the fake calculus LMF to LKF. Is the base for other prfal translations.

decide_ke (mcert C prf) I (mcert C' prf) :- decidem_ke C I C'.

store_kc  (mcert C tns) _ relind (mcert C prf).
store_kc  (mcert C prf) F I (mcert C' prf) :- storem_kc C F I C'.

release_ke (mcert C prf) (mcert C' prf) :- releasem_ke C C'.

% relation
initial_ke (mcert _ tns) relind.
initial_ke (mcert C prf) I :- initialm_ke C I.

orNeg_kc (mcert C prf) F (mcert C' prf) :- orNegm_kc C F C'.
orNeg_kc (mcert C tns) _ (mcert C tns).

andNeg_kc (mcert C prf) F (mcert C' prf) (mcert C'' prf) :- andNegm_kc C F C' C''.

andPos_k (mcert C tns) F S (mcert C' tns) (mcert C'' prf) :- andPosm_k C F S C' C''.

all_kc (mcert C prf) (Eigen\ mcert (C' Eigen) tns) :- boxm_kc C C'.

some_ke (mcert C prf) T (mcert C' tns) :- diam_ke C T C'.
