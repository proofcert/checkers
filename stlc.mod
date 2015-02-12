module stlc.
accumulate ljf-kernel.
/* Please read README.org, section FPCs, subsection STLC*/

/* Bureau (in order of appearance) 
The IGNORE parameter is the list of eigenVars, useless for this cert.
 */
arr_jc X _ X.
storeR_jc X _ X.
storeL_jc (lcert IGNORE C Term) _  (dep C) (lcert IGNORE C' Term) :- C' is C + 1.
releaseR_je X X.
initialL_je X.
decideL_je (lcert IGNORE C Term) INDEX  (lbody IGNORE C ListArgs) :- 
    getHeadAndArgs Term HEAD nil ListArgs,
    ((HEAD = (lvar H), D is (C - H - 1), INDEX = (dep D));
     (HEAD = (name S), INDEX = iname S)).
arr_je (lbody IGNORE  C [A|Rest]) _ (lcert IGNORE  C A) (lbody IGNORE  C Rest).

/* Utils */
ltype2form (typvar I) (n (tatm I)).
ltype2form (A t=> B) (A' arr B') :- ltype2form A A', ltype2form B B'.
ltype2form (t_ T) (n T).

/*
getHeadAndArgs digs for the head while stacking the arguments (this way they
are in the right order.
The final call (the head is found) puts the accumulated list in the result list.
MUST BE CALLED with a the first list at NIL.
e.g
getHeadAndArgs (3 (2 1)) (2 0) 3 _ [2 1, 2 0]
*/
getHeadAndArgs (name S) (name S) L L.
getHeadAndArgs (lvar I) (lvar I) L L.
getHeadAndArgs ( M lapp N) I L L' :- getHeadAndArgs M I (N :: L) L'.

/* Testing */
% (3 (2 1)) (2 0) : (a->a->b)->(c->a)->c->c->b

/*
Uncomment this when lapp is infix

ofType 1 (lapp (lapp (lvar 3) (lapp (lvar 2) (lvar 1))) (lapp (lvar 2) (lvar 0))) 
    ( ((typvar 1) t=> (typvar 1) t=> (typvar 2)) t=>
    	     ((typvar 3) t=> (typvar 1)) t=> (typvar 3) t=> (typvar 3) t=> (typvar 2) ).

% Actually, even \x\y. x (\w. y w), that gives 1 (1 0), of type 
% ((a->b) -> c) -> (a->b)->c, can be checked. 
% Problem (??) the term 1 (1 0) is also debruijn rep of \x\y. x (x y), of type (a->a)->a->a
% Is that okay ? 
% More importantly : is it always true that BEHNF, even those with abstraction in the body
% are checked by the same mechanism (informed guess : yes) Let's check it

ofType 2 
       (lapp (lvar 1) (lapp (lvar 1)(lvar 0)))

       ((((typvar 1) t=> (typvar 2)) t=> (typvar 3)) 
       t=> ((typvar 1) t=> (typvar 2)) 
       t=> (typvar 3)).

ofType 3 % Notice same term as 2
       (lapp (lvar 1) (lapp (lvar 1)(lvar 0)))
       (((typvar 1) t=> (typvar 1)) t=> (typvar 1) t=> (typvar 1)).


*/


stlcT 1 :- 
   spyV 0 "" (ofType 1 Term Type),
   spyV 0 "" (ltype2form Type Form),
   spyV 0 "" (entry_pointLJF (lcert nil 0 Term) Form).

stlcT 0 :-
   ofType _ Term Type,
   ltype2form Type Form,
   entry_pointLJF (lcert nil 0 Term) Form,
   print "SUCCESS\n\n\n",
   fail.