module resolution_steps.

% gets a sequent |- A &+& B, C, D &+& E, etc.

% here (resolution) we dont care about eigenvariables so we must add that.
eigencopy A A.

% do we need it here?
release_ke (rsteps A B) (rsteps A B).
% breaking the !-! in the formula
orNeg_kc (rsteps A B) _  (rsteps A B).
% storing when the index is not given and therefore, not used by experts
% storing true (last cut)
store_kc (rsteps [] B) t+ tlit (rsteps [] B).
% storing the operands of the !-!
store_kc (rsteps A estate) C (idx I) (rsteps A estate) :-
  mapsto (idx I) C.
% the same but using given indices for storing the operands
store_kc (rsteps A (istate [I|IL])) C (idx I) (rsteps A (istate IL)).
store_kc (rsteps A _) C (idx I) (rsteps A _). % storing all other none-indexed formulas

cut_ke A B C D :- fail. % this is required due to a bug in Teyjus where no backtracking is performed when a relation is defined in two different files. Backtracking is performed when we add this fail.
cut_ke (rsteps [R] B) f- (dlist I J) (rsteps [] B) :-
  res_step R I J K,
  mapsto (idx K) t+.
% Cuts correspond to resolve steps except for the last resolve
cut_ke (rsteps [R,R1 | RR] B) NC (dlist I' J') (rsteps [R1|RR] B):-
  res_step R I J K,
  mapsto (idx K) CutForm,
 negateForm CutForm NC. %we would like to do the dlist on the left and also to input the resolvent as cut formulas, therefore we must negateForm it.
res_step (resolv I J K) I J K.

% this decide is being called after the last cut
decide_ke (rsteps [] B) tlit done.
true_ke (done).
