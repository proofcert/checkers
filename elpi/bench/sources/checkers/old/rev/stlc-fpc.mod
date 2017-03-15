module stlc-fpc.

arr_jc      Cert Cert &
storeR_jc   Cert Cert &
releaseR_je Cert Cert :- Cert = (lc _ _).

storeL_jc   (lc C D) (lc C' D) (idx C) :- C' is C + 1.
initialL_je (args C []).
decideL_je  (lc C (apply H A)) (args C A) (idx V) :- V is C - H - 1.
arr_je      (args C (A::As)) (lc C A) (args C As).
