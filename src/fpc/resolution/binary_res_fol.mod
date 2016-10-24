module binary_res_fol.

% Proving the sequent can be proved by deciding clauses C1, C2 and some other clause.

store_kc (dlist C1 C2) _ lit (dlist C1 C2).
store_kc (dlist2 C1 S) _ lit (dlist2 C1 S).
store_kc (dlist3 S) _ lit (dlist3 S).
andPos_ke (dlist C1 C2) _  (dlist C1 C2) (dlist C1 C2).
andPos_ke (dlist2 C1 S) _  (dlist2 C1 S) (dlist2 C1 S).
andPos_ke (dlist3 S) _  (dlist3 S) (dlist3 S).
orNeg_kc (dlist C1 C2) _  (dlist C1 C2).
orNeg_kc (dlist2 C1 S) _  (dlist2 C1 S).
orNeg_kc (dlist3 S) _  (dlist3 S).
initial_ke (dlist _ _) _.
initial_ke (dlist2 _ _) _.
initial_ke (dlist3 _) _.
initial_ke done _.
release_ke (dlist C1 C2) (dlist C1 C2).
release_ke (dlist2 C1 S) (dlist2 C1 S).
release_ke (dlist3 S) (dlist3 S).
% here we decide the clauses for proving -C1,-C2,C3 of decide depth 3.
% Note that since they might be negative, we will need sometimes to decide on the cut formula
% This cut formula is indexed by lit but all other resolvents from previous
% steps are indexed by idx, so we need to either decide on C1, C2 or lit
decide_ke (dlist (rid I S) C2) I (dlist2 C2 S).
decide_ke (dlist C1 (rid I S)) I (dlist2 C1 S).
decide_ke (dlist C1 C2) lit (dlist2 C1 (sub [])).
decide_ke (dlist C1 C2) lit (dlist2 C2 (sub [])).
decide_ke (dlist2 (rid I S) (sub [])) I (dlist3 S).
decide_ke (dlist2 _ (sub [])) lit (dlist3 (sub [])).
decide_ke (dlist3 (sub [])) lit done.
% the last cut is over t+ and we need to eliminate its negation
false_kc (dlist C1 C2) (dlist C1 C2).
% clauses are in prefix normal form and we just apply the sub in the right order
some_ke (dlist2 C (sub [T])) T (dlist2 C (sub [])).
some_ke (dlist2 C (sub [T,T2|R])) T (dlist2 C (sub [T2|R])).
some_ke (dlist3 (sub [T])) T (dlist3 (sub [])).
some_ke (dlist3 (sub [T,T2|R])) T (dlist3 (sub [T2|R])).
