module lmf-lkf.

accumulate modal-encoding.

% Translation between the fake calculus LMF to LKF. Is the base for other prfal translations.

decide_ke (mcert C prf) I (mcert C' prf) :- decidem_ke C I C'.

store_kc  (mcert C tns) _ relind (mcert C prf).
store_kc  (mcert C prf) F I (mcert C' prf) :- modalToLK (FM,F), storem_kc C FM I C'.

release_ke (mcert C prf) (mcert C' prf) :- releasem_ke C C'.

% relation
initial_ke (mcert _ tns) relind.
initial_ke (mcert C prf) I :- initialm_ke C I.

orNeg_kc (mcert C prf) F (mcert C' prf) :- modalToLK (FM,F), orNegm_kc C FM C'.
orNeg_kc (mcert C tns) _ (mcert C tns).

andNeg_kc (mcert C prf) F (mcert C' prf) (mcert C'' prf) :- modalToLK (FM,F), andNegm_kc C FM C' C''.

andPos_k (mcert C tns) _ S (mcert C' tns) (mcert C'' prf) :- modalToLK (FM,F), andPosm_k C FM S C' C''.

all_kc (mcert C prf) (Eigen\ mcert (C' Eigen) tns) :- boxm_kc C C'.

some_ke (mcert C prf) T (mcert C' tns) :- diam_ke C T C'.
