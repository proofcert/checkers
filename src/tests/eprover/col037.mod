module col037.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

resProblem "col037" [(pr 32 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply s X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) ( apply X2 X3 ) ))) )) )) )) ),
(pr 31 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )) ),
(pr 31 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )) ),
(pr 31 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )) ),
(pr 31 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )) ),
(pr 32 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply s X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) ( apply X2 X3 ) ))) )) )) )) ),
(pr 31 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )) ),
(pr 31 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )) ),
(pr 31 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )) ),
(pr 31 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )) ),
(pr 32 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply s X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) ( apply X2 X3 ) ))) )) )) )) ),
(pr 14 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply b X1 ) X2 ) X3 ) == ( apply X1 ( apply X2 X3 ) ))) )) )) )) ),
(pr 32 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply s X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) ( apply X2 X3 ) ))) )) )) )) ),
(pr 31 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )) ),
(pr 31 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )) ),
(pr 31 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )) ),
(pr 4 (all (X1\ (p (( apply X1 ( f X1 ) ) == ( apply ( f X1 ) ( apply X1 ( f X1 ) ) ))) )) )] 
(rsteps [pm (id (idx 10)) (id (idx 11)) 9, pm (id (idx 10)) (id (idx 9)) 7, pm (id (idx 10)) (id (idx 7)) 5, pm (id (idx 4)) (id (idx 5)) 3, pm (id (idx 14)) (id (idx 15)) 13, pm (id (idx 13)) (id (idx 16)) 12, pm (id (idx 3)) (id (idx 12)) 2, pm (id (idx 22)) (id (idx 23)) 21, pm (id (idx 22)) (id (idx 21)) 19, pm (id (idx 22)) (id (idx 19)) 17, pm (id (idx 2)) (id (idx 17)) 1, pm (id (idx 31)) (id (idx 32)) 30, pm (id (idx 31)) (id (idx 30)) 28, pm (id (idx 31)) (id (idx 28)) 26, pm (id (idx 31)) (id (idx 26)) 24, pm (id (idx 1)) (id (idx 24)) 0] estate )
 (map [
pr 2 (all (X1\ (p (( apply ( apply ( apply ( apply s b ) ( apply c ( apply ( apply s ( apply c c ) ) c ) ) ) ( f ( apply X1 X1 ) ) ) X1 ) == ( apply ( apply X1 X1 ) ( f ( apply X1 X1 ) ) ))) )),
pr 4 (all (X1\ (p (( apply X1 ( f X1 ) ) == ( apply ( f X1 ) ( apply X1 ( f X1 ) ) ))) )),
pr 0 f-,
pr 11 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply s X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) ( apply X2 X3 ) ))) )) )) )),
pr 15 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply s X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) ( apply X2 X3 ) ))) )) )) )),
pr 23 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply s X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) ( apply X2 X3 ) ))) )) )) )),
pr 32 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply s X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) ( apply X2 X3 ) ))) )) )) )),
pr 14 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply b X1 ) X2 ) X3 ) == ( apply X1 ( apply X2 X3 ) ))) )) )) )),
pr 9 (all (X1\ (all (X3\ (all (X2\ (n (( apply ( apply ( apply s ( apply c X1 ) ) X3 ) X2 ) == ( apply ( apply X1 ( apply X3 X2 ) ) X2 ))) )) )) )),
pr 21 (all (X1\ (all (X3\ (all (X2\ (n (( apply ( apply ( apply s ( apply c X1 ) ) X3 ) X2 ) == ( apply ( apply X1 ( apply X3 X2 ) ) X2 ))) )) )) )),
pr 30 (all (X1\ (all (X3\ (all (X2\ (n (( apply ( apply ( apply s ( apply c X1 ) ) X3 ) X2 ) == ( apply ( apply X1 ( apply X3 X2 ) ) X2 ))) )) )) )),
pr 5 (all (X1\ (all (X2\ (n (( apply ( apply ( apply ( apply s ( apply c c ) ) c ) X1 ) X2 ) == ( apply ( apply X1 X1 ) X2 ))) )) )),
pr 17 (all (X1\ (all (X2\ (n (( apply ( apply ( apply ( apply s ( apply c c ) ) c ) X1 ) X2 ) == ( apply ( apply X1 X1 ) X2 ))) )) )),
pr 26 (all (X1\ (all (X2\ (n (( apply ( apply ( apply ( apply s ( apply c c ) ) c ) X1 ) X2 ) == ( apply ( apply X1 X1 ) X2 ))) )) )),
pr 7 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply ( apply s ( apply c c ) ) X1 ) X2 ) X3 ) == ( apply ( apply ( apply X1 X2 ) X3 ) X2 ))) )) )) )),
pr 19 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply ( apply s ( apply c c ) ) X1 ) X2 ) X3 ) == ( apply ( apply ( apply X1 X2 ) X3 ) X2 ))) )) )) )),
pr 28 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply ( apply s ( apply c c ) ) X1 ) X2 ) X3 ) == ( apply ( apply ( apply X1 X2 ) X3 ) X2 ))) )) )) )),
pr 12 (all (X2\ (all (X1\ (all (X3\ (n (( apply X2 ( apply ( apply X1 X3 ) X2 ) ) == ( apply ( apply ( apply ( apply s b ) ( apply c X1 ) ) X2 ) X3 ))) )) )) )),
pr 6 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )),
pr 8 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )),
pr 10 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )),
pr 16 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )),
pr 18 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )),
pr 20 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )),
pr 22 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )),
pr 25 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )),
pr 27 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )),
pr 29 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )),
pr 31 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply c X1 ) X2 ) X3 ) == ( apply ( apply X1 X3 ) X2 ))) )) )) )),
pr 3 (all (X1\ (p (( apply ( f ( apply X1 X1 ) ) ( apply ( apply ( apply ( apply s ( apply c c ) ) c ) X1 ) ( f ( apply X1 X1 ) ) ) ) == ( apply ( apply X1 X1 ) ( f ( apply X1 X1 ) ) ))) )),
pr 24 (all (X1\ (all (X2\ (n (( apply ( apply ( apply ( apply s ( apply c c ) ) c ) ( apply c X1 ) ) X2 ) == ( apply ( apply X1 X2 ) ( apply c X1 ) ))) )) )),
pr 13 (all (X2\ (all (X1\ (all (X3\ (n (( apply ( apply ( apply ( apply s b ) X2 ) X1 ) X3 ) == ( apply X1 ( apply ( apply X2 X1 ) X3 ) ))) )) )) )),
pr 1 (all (X1\ (p (( apply ( apply ( apply ( apply s ( apply c c ) ) c ) X1 ) ( f ( apply X1 X1 ) ) ) == ( apply ( apply ( apply ( apply s b ) ( apply c ( apply ( apply s ( apply c c ) ) c ) ) ) ( f ( apply X1 X1 ) ) ) X1 ))) ))
]).

inSig apply.
inSig f.


