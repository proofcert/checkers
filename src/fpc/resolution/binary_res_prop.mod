module binary_res_prop.

% Proving the sequent can be proved by deciding clauses C1, C2 and some other clause.

store_kc (dlist C1 C2) _ lit (dlist C1 C2).
andPos_ke (dlist C1 C2) _  (dlist C1 C2) (dlist C1 C2).
andPos_ke (dlist2 C1) _  (dlist2 C1) (dlist2 C1).
andPos_ke dlist3 _  dlist3 dlist3.
initial_ke (dlist _ _) _.
initial_ke (dlist2 _) _.
initial_ke dlist3 _.
release_ke (dlist C1 C2) (dlist C1 C2).
% here we decide the clauses for proving -C1,-C2,C3 of decide depth 3
decide_ke (dlist (rclause I) C2) (idx I) (dlist2 C2).
decide_ke (dlist C1 (rclause I)) (idx I) (dlist2 C1).
decide_ke (dlist2 (rclause I)) (idx I) dlist3.
decide_ke dlist3 _ done.
% the last cut is over t+ and we need to eliminate its negation
false_kc (dlist C1 C2) (dlist C1 C2).
