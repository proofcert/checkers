module jhc-fpc.

% Clerks and Experts, sorted by constructors
/* start */
arr_jc      (load (I::Tlabs) Justs) (load (I::Tlabs) Justs).
storeL_jc   (load (I::Tlabs) Justs) (load Tlabs Justs) I.
storeR_jc   (load nil Justs) (jlist Justs).

cut_je      (jlist (tup I Atom Rule Premises::Justs)) 
            (apply Rule Premises)
            (jlist (tup I Atom Rule Premises::Justs)) 
            (p Atom).
storeL_jc   (jlist (tup I Atom Rule Premises::Justs))
            (jlist Justs) I.
decideR_je  (jlist nil) done.

initialR_je done I.

storeR_jc   (apply Rule Premises) (apply Rule Premises).
decideL_je  (apply Rule Premises) (args Premises) Rule.

all_je      (args Premises) (args Premises) T.
arr_je      (args (P::Premises)) (finish P) (args Premises).
releaseL_je (args nil) initL.

storeL_jc   initL initL terminal.
decideR_je  initL initL.
initialR_je initL terminal.

initialR_je (finish P) P.
/* end */
