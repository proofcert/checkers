module mimic.
accumulate ljf-kernel.


decideL_je (mim (one I) Choice [] X) I (mim none Choice [I] X) &
decideR_je (mim (one I) Choice [] I) (mim none Choice [] I). %:- reverse Choice Choice'.

storeL_jc (mim Root Choice [I|Rest] X) _ I (mim Root Choice Rest X) .
storeR_jc (mim A B C D) _ (mim A B C D).
initialL_je (mim _ _ [I] I).
initialR_je (mim _ _ [] I) I.
releaseL_je (mim none Choices [I] X) (mim (one I) nil [I] X).
releaseR_je (mim none Choices [ ] I) (mim (one I) nil [ ] I).
arr_jc (mim Root Choice [] I) _ (mim Root Choice [<<(I)] (>>(I))).
andPos_jc (mim Root Choice [I|Rest] X) _ (mim Root Choice [<<(I),>>(I)|Rest] X).
arr_je 	(mim none Choice [I] X) _ (mim none Choice [] (<<(I))) (mim none Choice [>>(I)] X).
andPos_je (mim none Choice [] I) _ (mim none Choice [] (<<(I))) (mim none Choice [] (>>(I))).
andNeg_jc (mim Root Dir [] I) _ (mim Root [<<(I)|Dir] [] (<<(I))) 
                                (mim Root [>>(I)|Dir] [] (>>(I))).
or_jc (mim Root Dir [I|Rest] X) _ (mim Root [<<(I)|Dir] [<<(I)|Rest] X)
           	    	     	  (mim Root [>>(I)|Dir] [>>(I)|Rest] X).
or_je (mim none Dir [] I) _ left (mim none Dir' [] (<<(I))) &
andNeg_je  (mim none Dir [I] X) _ left (mim none Dir' [<<(I)] X) :-
      memb_and_rest (<<(I)) Dir Dir'.
or_je (mim none Dir [] I) _ right (mim none Dir' [] (>>(I))) &
andNeg_je (mim none Dir [I] X) _ right (mim none Dir' [>>(I)] X) :-
      memb_and_rest (>>(I)) Dir Dir'.
/*andNeg_jc (mim Root Choice [] I) _   (mim Root [left|Choice]  [] (<<(I)))     (mim Root [right|Choice] [] (>>(I))).
or_jc (mim Root Choice [I|Rest] X) _ (mim Root [left|Choice]  [<<(I)|Rest] X) (mim Root [right|Choice] [>>(I)|Rest] X).
andNeg_je  (mim none [C|Choice] [I] X) _ C (mim none Choice [NextI] X) &
or_je (mim none [C|Choice] [] I) _ C (mim none Choice [] NextI) :-
   (C = left,  NextI = << I);
   (C = right, NextI = >> I).
*/

/* Test */
getLine 0 ((n A) arr (n C)).
getLine 1 ((p A) !! (n B)).
getLine 2 ((p A) &+& (n B)).
getLine 3 ((n A) &-& (p C)).
getLine 4 (((n A) arr (n C)) arr ((p A) !! (n B))  !! ((p A) &+& (n B)) ).
getLine 5 ((p A !! p B) &+& (p C !! p D)).
getLine 6 ((p A !! p B) &+& (p C !! ((p D) &+& (p E)))).
getLine 7 ((p A !! (p B &+& (p F))) &+& (p C !! ((p D) &+& (p E)))).
getLine 8 ((A !! B) &+& C) :- getLine 0 C, getLine 6 B, getLine 5 A.

testmim I :- 
   getLine I Form,
   spyV 1 "bottom sequent LJF " 
       (check (mim (one $) [] [$] $) (unfJ [Form] (str- Form))).
