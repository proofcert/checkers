module dtlc.
accumulate stlc.

/*WHERE I AM AT : 

*/


/* Bureau */
all_jc (lcert EigenVars C Term) (x\ lcert [pr x C|EigenVars] C Term).
all_je (lbody EigenVars C [(lvar I)|ListArgs]) U (lbody EigenVars C [(lvar I)|ListArgs]) :-
  spyV 1 "CALCUL" ( V is C - I - 1),
  spyV 1 "MEMBER" ( member (pr U V) EigenVars).

/*Utils (Think of a better format for the base types*/
ltype2form (piT Ty Rest) (all (x\ Fy arr (F x))) :-
   ltype2form Ty Fy,
   pi x\ ltype2form (Rest x) (F x).
   
/*  TEST  */
% QUESTION : IS IT attackable ? It seems vulnerable.
ofType 103 ((name "append") lapp (lvar 3) lapp (lvar 2) lapp (lvar 1) lapp (lvar 0))
         (piT (t_ nat) x\  piT (t_ nat) y\ (t_ (vec x)) t=> (t_ (vec y)) t=> (t_ (vec (x l+ y)))).

ofType 101 (lvar 0) (piT (t_ nat) x\ (t_ nat)).
/*
localLib [pr (name "append") (piT nat x\  piT nat y\ vec x t=> vec y t=> vec (x l+ y))].
*/
dtlcT 1 :- 
   spyV 1 "" (ltype2form (piT (t_ nat) x\  
                            piT (t_ nat) y\ 
                               (t_ (vec x)) t=> (t_ (vec y)) t=> (t_ (vec (x l+ y)))) 
      	   	APPEND) ,
      	   ofType 103 Term Ty,
	  spyV 1 "" ( ltype2form Ty Thm),
           inCtxt (iname "append") APPEND => 
	   entry_pointLJF (lcert nil 0 Term) Thm.

dtlcT 2 :- ofType 101 IdTerm Ty,
      ltype2form Ty Thm,
      entry_pointLJF (lcert nil 0 IdTerm) Thm.
/*SHOULD NOT PASS and doesn't : yay*/
dtlcT 3 :- 
   spyV 1 "" (ltype2form (piT (t_ nat) x\  
                            piT (t_ nat) y\ 
                               (t_ (vec x)) t=> (t_ (vec y)) t=> (t_ (vec (y l+ x)))) 
      	   	APPEND) ,
      	   ofType 103 Term Ty,
	  spyV 1 "" ( ltype2form Ty Thm),
           inCtxt (iname "append") APPEND => 
	   entry_pointLJF (lcert nil 0 Term) Thm.