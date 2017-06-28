module lmf-lkf.

% Translation between the fake calculus LMF to LKF. Is the base for other prfal translations.

decide_ke (mcert C prf [] Fms Lbls) I (mcert C' prf [MF] Fms Lbls) :- member (pr I MF) Fms, decidem_ke C I MF C'.

store_kc  (mcert C tns MF Fms Lbls) _ relind (mcert C prf MF Fms Lbls).
store_kc  (mcert C prf [MF|R] Fms Lbls) F I (mcert C' prf R [(pr I MF)|Fms] Lbls) :- storem_kc C MF I C'.

release_ke (mcert C prf MF Fms Lbls) (mcert C' prf MF Fms Lbls) :- releasem_ke C C'.

% relation
initial_ke (mcert _ tns _ _ _) relind.
initial_ke (mcert C prf _ _ _) I :- initialm_ke C I.

orNeg_kc (mcert C prf [lform L (A !! B)| R] Fms Lbls) F (mcert C' prf [lform L A,lform L B|R] Fms Lbls) :- orNegm_kc C (lform L (A !! B)) C'.
orNeg_kc (mcert C tns MF Fms Lbls) _ (mcert C tns MF Fms Lbls).

andNeg_kc (mcert C prf [lform L (A && B)|R] Fms Lbls) F (mcert C' prf [lform L A|R] Fms Lbls) (mcert C'' prf [lform L B|R] Fms Lbls) :-
  andNegm_kc C (lform L (A&&B)) C' C''.

andPos_k (mcert C tns MF Fms Lbls) _ S (mcert C' tns _ Fms Lbls) (mcert C prf MF Fms Lbls).

all_kc (mcert C prf [lform L (box MF)|R] Fms Lbls) (Eigen\ mcert (C' Eigen) tns [lform Eigen MF|R] Fms [pr Eigen Lbl| Lbls]) :-
  boxm_kc C Lbl C'.

some_ke (mcert C prf [lform L (dia MF)|R] Fms Lbls) Eigen (mcert C' tns [lform Eigen MF|R] Fms Lbs) :-
  diam_ke C T C', member (pr Eigen T) Lbls.
