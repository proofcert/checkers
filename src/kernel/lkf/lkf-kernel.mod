% 29 july 2014.
module lkf-kernel.
accumulate lists.
accumulate debug.

% Entry point
entry_point Cert Form :-
spy ""
  (check Cert (unfK [Form])).

%%%%%%%%%%%%%%%%%%
% Structural Rules
%%%%%%%%%%%%%%%%%%

% decide
check Cert (unfK nil) :-
  spy "" (decide_ke Cert Indx Cert'),
  spy "inContext " (inCtxt Indx P),
  isPos P,
  spy "Deciding " (check Cert' (foc P)).
% release
check Cert (foc N) :-
  isNeg N,
  spy "" (release_ke Cert Cert'),
  spy "Releasing " (check Cert' (unfK [N])).
% store
check Cert (unfK [C|Rest]) :-
  (isPos C ; isNegAtm C),
  eigencopy C' C,
  spy "" (store_kc Cert C Indx Cert'),
  inCtxt Indx C => spy "Storing " (check Cert' (unfK Rest)).
% initial
check Cert (foc (p A)) :-
  spy "" (initial_ke Cert Indx),
  spy "Init " (inCtxt Indx (n A)).
% cut
check Cert (unfK nil) :-
  spy "" (cut_ke Cert F CertA CertB),
  negateForm F NF,
  spy "Cut left " (check CertA (unfK [F])),
  spy "Cut right " (check CertB (unfK [NF])).

%%%%%%%%%%%%%%%%%%%%
% Asynchronous Rules
%%%%%%%%%%%%%%%%%%%%

% orNeg
check Cert (unfK [A !-! B | Rest]) :-
  spy "" (orNeg_kc Cert (A !-! B)  Cert'),
  spy "Or- " (check Cert' (unfK [A, B| Rest])).
% conjunction
check Cert (unfK [A &-& B | Rest]) :-
  spy "" (andNeg_kc Cert (A &-& B) CertA CertB),
  spy "And- left " (check CertA (unfK [A | Rest])),
  spy "And- right " (check CertB (unfK [B | Rest])).
% forall
check Cert (unfK [all B | Theta]) :-
  spy "" (all_kc Cert Cert'),
  spy "All " (pi w\ (normalize (check (Cert' w) (unfK [B w | Theta] )))). % Teyjus bug doesn perform beta-reduction on inner reducts!!!
% Units
check Cert (unfK [t-|_]). % No clerk - justify in the paper ?
check Cert (unfK [f-|Gamma]) :-  % Fix the name, between Theta, Teta, Gamma !
  spy "" (false_kc Cert Cert'),
  spy "False " (check Cert' (unfK Gamma)).
% delay
check Cert (unfK [d- A| Teta]) :-
  spy "NegDelay" (check Cert (unfK [A| Teta])).

%%%%%%%%%%%%%%%%%%%
% Synchronous Rules
%%%%%%%%%%%%%%%%%%%
% conjunction
check Cert (foc (A &+& B)) :-
   spy "" (andPos_k Cert (A &+& B) Direction CertA CertB),
   ((Direction = left-first,
   spy "And+ left " (check CertA (foc A)),
   spy "And+ right " (check CertB (foc B)));
   (Direction = right-first,
    spy "And+ right " (check CertB (foc B)),
    spy "And+ left " (check CertA (foc A)))).
%   spy "And+ left " (check CertA (foc A)),
%   spy "And+ right " (check CertB (foc B)).
% disjunction
check Cert (foc (A !+! B)) :-
  spy "" (orPos_ke Cert (A !+! B) Choice Cert'),
  ((Choice = left,  spy "Or+ left " (check Cert' (foc A)));
   (Choice = right, spy "Or+ right " (check Cert' (foc B)))).
% quantifers
check Cert (foc (some B)) :-
  spy "" (some_ke Cert T Cert'),
  eigencopy T T',
  eager_normalize (B T') C, % required as Teyjus doesnt normalize it before pattern matching.
  spy "Some " (check Cert' (foc (C))).
% Units
check Cert (foc t+) :-
  spy "" (true_ke Cert).
% delay
check Cert (foc (d+ A)) :-
  spy "PosDelay " (check Cert (foc A)).

%%%%%%%%%%%
% Utilities
%%%%%%%%%%%

eager_normalize A B :- A = B.

isNegForm (_ &-& _).
isNegForm (_ !-! _).
isNegForm (d- _).
isNegForm (all _).
isPosForm (_ &+& _).
isPosForm (d+ _).
isPosForm (_ !+!  _).
isNegAtm (n _).
isPosAtm (p _).
isAtm A :- isNegAtm A ; isPosAtm A.
isPosForm (some _).
isPosForm t+.
isPosForm f+.
isNegForm f-.
isNegForm t-.
isCompForm A :- isNegForm A ; isPosForm A.

isNeg A :- isNegForm A ; isNegAtm A.
isPos A :- isPosForm A ; isPosAtm A.
isPosUM A :- isPos A ; isNegAtm A.

negateForm f- t+.
negateForm t+ f-.
negateForm t- f+.
negateForm f+ t-.

negateForm (p A) (n A).
negateForm (n A) (p A).
negateForm (A &+& B)  (NA !-! NB) &
negateForm (A !-! B)  (NA &+& NB) &
negateForm (A &-& B)  (NA !+! NB) &
negateForm (A !+! B)  (NA &-& NB) :- negateForm A NA, negateForm B NB.
negateForm (all B)  (some NB) &
negateForm (some B) (all NB) :- pi x\ negateForm (B x) (NB x).

andPos_k Cert (A &+& B) left-first CertA CertB :-
   andPos_ke Cert (A &+& B) CertA CertB.

