module col061.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

resProblem "col061" [(pr 12 (all (X1\ (all (X2\ (n (( apply ( apply t X1 ) X2 ) == ( apply X2 X1 ))) )) )) ),
(pr 11 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply b X1 ) X2 ) X3 ) == ( apply X1 ( apply X2 X3 ) ))) )) )) )) ),
(pr 11 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply b X1 ) X2 ) X3 ) == ( apply X1 ( apply X2 X3 ) ))) )) )) )) ),
(pr 11 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply b X1 ) X2 ) X3 ) == ( apply X1 ( apply X2 X3 ) ))) )) )) )) ),
(pr 12 (all (X1\ (all (X2\ (n (( apply ( apply t X1 ) X2 ) == ( apply X2 X1 ))) )) )) ),
(pr 11 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply b X1 ) X2 ) X3 ) == ( apply X1 ( apply X2 X3 ) ))) )) )) )) ),
(pr 6 (all (X1\ (p (( apply ( apply ( apply X1 ( f X1 ) ) ( g X1 ) ) ( h X1 ) ) == ( apply ( f X1 ) ( apply ( h X1 ) ( g X1 ) ) ))) )) )] 
(rsteps [pm (id (idx 6)) (id (idx 7)) 5, pm (id (idx 5)) (id (idx 8)) 4, pm (id (idx 4)) (id (idx 9)) 3, pm (id (idx 3)) (id (idx 10)) 2, pm (id (idx 2)) (id (idx 11)) 1, pm (id (idx 1)) (id (idx 12)) 0] estate )
 (map [
pr 8 (all (X1\ (all (X2\ (n (( apply ( apply t X1 ) X2 ) == ( apply X2 X1 ))) )) )),
pr 12 (all (X1\ (all (X2\ (n (( apply ( apply t X1 ) X2 ) == ( apply X2 X1 ))) )) )),
pr 5 (all (X1\ (all (X2\ (p (( apply ( apply ( apply X1 ( apply X2 ( f ( apply ( apply b X1 ) X2 ) ) ) ) ( g ( apply ( apply b X1 ) X2 ) ) ) ( h ( apply ( apply b X1 ) X2 ) ) ) == ( apply ( f ( apply ( apply b X1 ) X2 ) ) ( apply ( h ( apply ( apply b X1 ) X2 ) ) ( g ( apply ( apply b X1 ) X2 ) ) ) ))) )) )),
pr 0 f-,
pr 1 (all (X1\ (p (( apply ( f ( apply ( apply b ( apply t X1 ) ) ( apply ( apply b b ) b ) ) ) ( apply ( apply X1 ( g ( apply ( apply b ( apply t X1 ) ) ( apply ( apply b b ) b ) ) ) ) ( h ( apply ( apply b ( apply t X1 ) ) ( apply ( apply b b ) b ) ) ) ) ) == ( apply ( f ( apply ( apply b ( apply t X1 ) ) ( apply ( apply b b ) b ) ) ) ( apply ( h ( apply ( apply b ( apply t X1 ) ) ( apply ( apply b b ) b ) ) ) ( g ( apply ( apply b ( apply t X1 ) ) ( apply ( apply b b ) b ) ) ) ) ))) )),
pr 7 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply b X1 ) X2 ) X3 ) == ( apply X1 ( apply X2 X3 ) ))) )) )) )),
pr 9 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply b X1 ) X2 ) X3 ) == ( apply X1 ( apply X2 X3 ) ))) )) )) )),
pr 10 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply b X1 ) X2 ) X3 ) == ( apply X1 ( apply X2 X3 ) ))) )) )) )),
pr 11 (all (X1\ (all (X2\ (all (X3\ (n (( apply ( apply ( apply b X1 ) X2 ) X3 ) == ( apply X1 ( apply X2 X3 ) ))) )) )) )),
pr 6 (all (X1\ (p (( apply ( apply ( apply X1 ( f X1 ) ) ( g X1 ) ) ( h X1 ) ) == ( apply ( f X1 ) ( apply ( h X1 ) ( g X1 ) ) ))) )),
pr 3 (all (X1\ (all (X2\ (all (X3\ (p (( apply ( apply ( apply ( apply X1 ( apply X2 ( f ( apply ( apply b ( apply t X3 ) ) ( apply ( apply b X1 ) X2 ) ) ) ) ) X3 ) ( g ( apply ( apply b ( apply t X3 ) ) ( apply ( apply b X1 ) X2 ) ) ) ) ( h ( apply ( apply b ( apply t X3 ) ) ( apply ( apply b X1 ) X2 ) ) ) ) == ( apply ( f ( apply ( apply b ( apply t X3 ) ) ( apply ( apply b X1 ) X2 ) ) ) ( apply ( h ( apply ( apply b ( apply t X3 ) ) ( apply ( apply b X1 ) X2 ) ) ) ( g ( apply ( apply b ( apply t X3 ) ) ( apply ( apply b X1 ) X2 ) ) ) ) ))) )) )) )),
pr 4 (all (X2\ (all (X1\ (p (( apply ( apply ( apply ( apply X2 ( f ( apply ( apply b ( apply t X1 ) ) X2 ) ) ) X1 ) ( g ( apply ( apply b ( apply t X1 ) ) X2 ) ) ) ( h ( apply ( apply b ( apply t X1 ) ) X2 ) ) ) == ( apply ( f ( apply ( apply b ( apply t X1 ) ) X2 ) ) ( apply ( h ( apply ( apply b ( apply t X1 ) ) X2 ) ) ( g ( apply ( apply b ( apply t X1 ) ) X2 ) ) ) ))) )) )),
pr 2 (all (X1\ (all (X2\ (p (( apply ( apply ( apply X1 ( f ( apply ( apply b ( apply t X2 ) ) ( apply ( apply b b ) X1 ) ) ) ) ( apply X2 ( g ( apply ( apply b ( apply t X2 ) ) ( apply ( apply b b ) X1 ) ) ) ) ) ( h ( apply ( apply b ( apply t X2 ) ) ( apply ( apply b b ) X1 ) ) ) ) == ( apply ( f ( apply ( apply b ( apply t X2 ) ) ( apply ( apply b b ) X1 ) ) ) ( apply ( h ( apply ( apply b ( apply t X2 ) ) ( apply ( apply b b ) X1 ) ) ) ( g ( apply ( apply b ( apply t X2 ) ) ( apply ( apply b b ) X1 ) ) ) ) ))) )) ))
]).

inSig h.
inSig apply.
inSig g.
inSig f.


