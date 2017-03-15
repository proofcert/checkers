module oracle-fpc.

decide_ke  (start Oracle) (consume Oracle) root. 
store_kc   (start Oracle) (start Oracle) root.

initial_ke (consume emp) lit.
true_ke    (consume emp).
andPos_ke  (consume (c OracleL OracleR)) (consume OracleL) (consume OracleR).
orPos_ke   (consume (l Oracle)) (consume Oracle) left.
orPos_ke   (consume (r Oracle)) (consume Oracle) right.
release_ke (consume Oracle) (restart Oracle).

decide_ke  (restart Oracle) (consume Oracle) root.
store_kc   (restart Oracle) (restart Oracle) lit.
