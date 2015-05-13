module COL052-1.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

resProblem "COL052-1" [(pr 8 (n (( response c ( common_bird X1 ) ) == ( response X1 ( common_bird X1 ) ))) ),
(pr 7 (n (( response ( compose X1 X2 ) X3 ) == ( response X1 ( response X2 X3 ) ))) ),
(pr 5 (n (c == ( compose a b ))) ),
(pr 7 (n (( response ( compose X1 X2 ) X3 ) == ( response X1 ( response X2 X3 ) ))) ),
(pr 2 (p (( response a X1 ) == ( response odd_bird X1 ))) )] 
(rsteps [pm (id (idx 4)) (id (idx 5)) 3, pm (id (idx 2)) (id (idx 3)) 1, pm (id (idx 7)) (id (idx 8)) 6, pm (id (idx 1)) (id (idx 6)) 0] estate )
 (map [
pr 5 (n (c == ( compose a b ))),
pr 8 (n (( response c ( common_bird X1 ) ) == ( response X1 ( common_bird X1 ) ))),
pr 4 (n (( response ( compose X1 X2 ) X3 ) == ( response X1 ( response X2 X3 ) ))),
pr 7 (n (( response ( compose X1 X2 ) X3 ) == ( response X1 ( response X2 X3 ) ))),
pr 2 (p (( response a X1 ) == ( response odd_bird X1 ))),
pr 0 f-,
pr 1 (p (( response c X1 ) == ( response odd_bird ( response b X1 ) ))),
pr 6 (n (( response c ( common_bird ( compose X1 X2 ) ) ) == ( response X1 ( response X2 ( common_bird ( compose X1 X2 ) ) ) ))),
pr 3 (n (( response c X1 ) == ( response a ( response b X1 ) )))
]).

inSig response.
inSig compose.
inSig common_bird.


