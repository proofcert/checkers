module lmf-lkf.

% Translation between the fake calculus LMF to LKF. Is the base for other prfal translations.

decide_ke (mcert C prf [] Fms) I (mcert C' prf [MF] Fms) :- member (pr I MF) Fms, decidem_ke C I MF C'.

store_kc  (mcert C tns MF Fms) _ relind (mcert C prf MF Fms).
store_kc  (mcert C prf [MF|R] Fms) F I (mcert C' prf R [(pr I MF)|Fms]) :- storem_kc C MF I C'.

release_ke (mcert C prf MF Fms) (mcert C' prf MF Fms) :- releasem_ke C C'.

% relation
initial_ke (mcert _ tns _ _) relind.
initial_ke (mcert C prf _ _) I :- initialm_ke C I.

orNeg_kc (mcert C prf [lform L (A !! B)| R] Fms) F (mcert C' prf [lform L A,lform L B|R] Fms) :- orNegm_kc C (lform L (A !! B)) C'.
orNeg_kc (mcert C tns MF Fms) _ (mcert C tns MF Fms).

andNeg_kc (mcert C prf [lform L (A && B)|R] Fms) F (mcert C' prf [lform L A|R] Fms) (mcert C'' prf [lform L B|R] Fms) :-
  andNegm_kc C (lform L (A&&B)) C' C''.

andPos_k (mcert C tns MF Fms) _ S (mcert C' tns _ _) (mcert C prf MF Fms).

all_kc (mcert C prf [lform L (box MF)|R] Fms) (Eigen\ mcert (C' Eigen) tns [lform Eigen MF|R] Fms) :- boxm_kc C _ C'.

some_ke (mcert C prf [lform L (dia MF)|R] Fms) T (mcert C' tns [lform T MF|R] Fms) :- diam_ke C T C'.
