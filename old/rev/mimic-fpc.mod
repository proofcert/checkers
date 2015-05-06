module mimic-fpc.

/* mimic */
arr_jc (mimic I) (aphaseL I [] [I] I).

decideL_je (aphaseR I Cs X) (sphaseL Cs I X) I.
decideR_je (aphaseR I Cs I) (sphaseR Cs   I).

storeL_jc (aphaseL Root Cs [I,J|R] X) (aphaseL Root Cs [J|R] X) I.
storeL_jc (aphaseL Root Cs [I] X)     (aphaseR Root Cs X) I.
storeR_jc (aphaseR Root Cs X)         (aphaseR Root Cs X).

initialL_je (sphaseL _ I I).
initialR_je (sphaseR _   I) I.

releaseL_je (sphaseL _ I X) (aphaseL I [] [I] X).
releaseR_je (sphaseR _   I) (aphaseR I []     I).

arr_jc    (aphaseR Root Cs I) (aphaseL Root Cs [mL I] (mR I)).
andNeg_jc (aphaseR Root Cs I) (aphaseR Root [mL I|Cs] (mL I))
                              (aphaseR Root [mR I|Cs] (mR I)).
andPos_jc (aphaseL Root Cs [I|R] X) (aphaseL Root Cs [mL I, mR I|R] X).
true_jc   (aphaseL Root Cs [I,J|R] X) (aphaseL Root Cs [J|R] X).
true_jc   (aphaseL Root Cs [I] X)     (aphaseR Root Cs X).
or_jc     (aphaseL Root Cs [I|R] X) (aphaseL Root [mL I|Cs] [mL I|R] X)
                                    (aphaseL Root [mR I|Cs] [mR I|R] X).

arr_je    (sphaseL Cs I X) (sphaseR Cs (mL I)) (sphaseL Cs (mR I) X).
andPos_je (sphaseR Cs   I) (sphaseR Cs (mL I)) (sphaseR Cs (mR I)).
true_je   (sphaseR Cs I).
or_je     (sphaseR Cs I)   (sphaseR Cs' (mL I))   left  &
andNeg_je (sphaseL Cs I X) (sphaseL Cs' (mL I) X) left  :-
   memb_and_rest (mL I) Cs Cs'.
or_je     (sphaseR Cs I)   (sphaseR Cs' (mR I))   right &
andNeg_je (sphaseL Cs I X) (sphaseL Cs' (mR I) X) right :-
   memb_and_rest (mR I) Cs Cs'.
/* end */

% Note that there are two clauses for storeL_jc and true_jc since they
% may need to make a transition to the asyncR phase.
