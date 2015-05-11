module col058.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

resProblem "col058" [(pr 11 (p (( response ( response lark X1 ) X2 ) == ( response X1 ( response X2 X2 ) ))) ),
(pr 11 (p (( response ( response lark X1 ) X2 ) == ( response X1 ( response X2 X2 ) ))) ),
(pr 11 (p (( response ( response lark X1 ) X2 ) == ( response X1 ( response X2 X2 ) ))) ),
(pr 11 (p (( response ( response lark X1 ) X2 ) == ( response X1 ( response X2 X2 ) ))) ),
(pr 11 (p (( response ( response lark X1 ) X2 ) == ( response X1 ( response X2 X2 ) ))) ),
(pr 4 (n (( response X1 X1 ) == X1)) )] 
(rsteps [pm (id (idx 7)) (id (idx 7)) 5, pm (id (idx 4)) (id (idx 5)) 3, pm (id (idx 3)) (id (idx 8)) 2, pm (id (idx 11)) (id (idx 11)) 9, pm (id (idx 2)) (id (idx 9)) 1, cn (id (idx 1)) 0] estate )
 (map [
pr 1 (n (( response ( response ( response lark lark ) ( response lark ( response lark lark ) ) ) ( response lark ( response lark lark ) ) ) == ( response ( response lark ( response ( response lark ( response lark lark ) ) ( response lark ( response lark lark ) ) ) ) ( response lark ( response lark lark ) ) ))),
pr 0 f-,
pr 5 (p (( response X1 ( response ( response lark ( response X2 X2 ) ) X2 ) ) == ( response ( response lark X1 ) ( response X2 X2 ) ))),
pr 9 (p (( response ( response ( response lark lark ) X1 ) X2 ) == ( response ( response X1 X1 ) ( response X2 X2 ) ))),
pr 2 (n (( response ( response ( response lark ( response lark lark ) ) X1 ) ( response X1 X1 ) ) == ( response ( response lark ( response X1 X1 ) ) X1 ))),
pr 3 (n (( response ( response lark ( response ( response lark ( response X1 X1 ) ) X1 ) ) ( response X1 X1 ) ) == ( response ( response lark ( response X1 X1 ) ) X1 ))),
pr 4 (n (( response X1 X1 ) == X1)),
pr 6 (p (( response ( response lark X1 ) X2 ) == ( response X1 ( response X2 X2 ) ))),
pr 7 (p (( response ( response lark X1 ) X2 ) == ( response X1 ( response X2 X2 ) ))),
pr 8 (p (( response ( response lark X1 ) X2 ) == ( response X1 ( response X2 X2 ) ))),
pr 10 (p (( response ( response lark X1 ) X2 ) == ( response X1 ( response X2 X2 ) ))),
pr 11 (p (( response ( response lark X1 ) X2 ) == ( response X1 ( response X2 X2 ) )))
]).

inSig response.


