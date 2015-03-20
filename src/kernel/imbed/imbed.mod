/*
 * Takes a certificate for LKF and double negates it so that
 * it can be checked with LJF.
 * (LKF == imbed + LJF)
 *
 */

module imbed.
accumulate  lkf-kernel, ljf-kernel.

/*
 * Formulation translation as found in the paper (Kaustuv)
 */
imbedForm+ (p A)      (p A).
imbedForm+ (N)        (TN arr f)  :-  isNeg N, imbedForm- N TN.
imbedForm+ (A !+! B ) (TA  !! TB) &
imbedForm+ (A &+& B ) (TA &+& TB) :- imbedForm+ A TA, imbedForm+ B TB.
imbedForm+ (f+) (f).
imbedForm+ (t+) (t).
imbedForm+ (some B)   (some TB )   :- pi x\ imbedForm+ (B x) (TB x).

imbedForm- (n A)      (p A).
imbedForm- (P)        (TP arr f)  :- isPos P, imbedForm+ P TP.
imbedForm- (A !-! B)  (TA &+& TB) &
imbedForm- (A &-& B)  (TA  !! TB) :- imbedForm- A TA, imbedForm- B TB.
imbedForm- (f-) (t).
imbedForm- (t-) (f).
imbedForm- (all B)    (some TB)   :-  pi x\ imbedForm- (B x) (TB x).

imbed-AllForm [] [].
imbed-AllForm [F|R][F'|R'] :- imbedForm- F F', imbed-AllForm R R'.

/*
 first thing to call to engage the checking
*/
entry_pointImbed Cert Form :-
    imbedSeq (unfK [Form]) Seq,
    check Cert Seq.
/*
Imbedding of sequent.
- Disparity with the paper because context is handled by LProlog
So cannot, for now, embed whole sequent
 => ONLY sequent with empty context. (Sufficient)
  [⊢  . ⇑  Δ]   into   [. ; [Δ]￣  ⊢ f ;.]
*/
imbedSeq (unfK D) (unfJ TD (str- f)) :-
    imbed-AllForm D TD.

/*
Imbedding the Bureau
- fcert is the vacuous cert given to the Agents dealing with "false"
*/

decideL_je C Indx C'    :- decide_ke C Indx C'.

releaseL_je fcert fcert.
releaseR_je C C'	:- release_ke C C'.

storeL_jc C F I C' 	:- store_kc C _ I C'.
storeR_jc C f C.

initialR_je C I		:- initial_ke C I.

some_jc C C'  		:- all_kc C C' .
some_je C T C' 		:- some_ke  C T C' .

andPos_jc C F C' 	:- orNeg_kc C _ C'.
andPos_je C F CA CB 	:- andPos_ke C _ CA CB.

or_jc C F CA CB  	:- andNeg_kc C _ CA CB.
or_je C F Choice C' 	:- orPos_ke C _ Choice C'.

arr_jc  C _ C  & arr_je C _ C fcert.

true_je C      	 	:- true_ke C.
true_jc C C' 		:- false_kc C C'.

cut_je C F CG CD :-
  cut_ke C F' CA CB,
  ((isNeg F', negate F' FF, imbedForm- FF F, CG = CA, CD = CB)
  ;
  (isPos F', imbedForm- F' F, CG = CB, CD = CA)).

/********
 Testing
*********/

test 1 X F :-
   imbedForm- ((X &-& X) !-! (X &+& (X !+! X))) F.
test 2 X F :-
  imbedForm-  F  ((p A !! p A) &+& ((p A arr f) &+& ((p A arr f) !! (p A arr f)) arr f)).

test 3 X F :- imbedForm- (X &-& X) F.

