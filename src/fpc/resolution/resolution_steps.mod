module resolution_steps.

% gets a sequent |- A &+& B, C, D &+& E, etc.

% do we need it here?
release_ke (rsteps A) (rsteps A).
% breaking the !-! in the formula
orNeg_kc (rsteps A) _  (rsteps A).
% storing when the index is not given and therefore, not used by experts
% storing true (last cut)
store_kc (rsteps []) t+ tlit (rsteps []).
% storing the operands of the !-!
store_kc (rsteps A) C (idx I) (rsteps A) :-
  mapsto I C.
cut_ke (rsteps [resolv I J K]) f- (dlist I J) (rsteps []) :-
  mapsto K t+.
% Cuts correspond to resolve steps except for the last resolve
cut_ke (rsteps [(resolv I J K),R1 | RR]) NC (dlist I J) (rsteps [R1|RR]):-
  mapsto K CutForm,
  negate CutForm NC. %we would like to do the dlist on the left and also to input the resolvent as cut formulas, therefore we must negate it.
% this decide is being called after the last cut
decide_ke (rsteps []) tlit done.
true_ke (done).
