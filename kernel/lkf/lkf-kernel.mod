% 29 july 2014.
% Paper Fidelity.
module lkf-kernel.
accumulate debug.
accumulate lists.

% Entry point
entry_pointLKF Cert Form :-
  spyV 1 "entring" (check Cert (unfK [Form])).

%%%%%%%%%%%%%%%%%%
% Structural Rules
%%%%%%%%%%%%%%%%%%

% decide
check Cert (unfK nil) :-
  spyV 1 "deciding" (decide_ke Cert Indx Cert'),
  spyV 1 "deciding" (inCtxt Indx P),
  isPos P,
  spyV 1 "decided" (check Cert' (foc P)).
% release
check Cert (foc N) :-
  isNeg N,
  release_ke Cert Cert',
  spyV 1 "released" (check Cert' (unfK [N])).
% store
check Cert (unfK [C|Rest]) :-
  (isPos C ; isNegAtm C),
  spyV 1 "storing " (store_kc Cert C Indx Cert'),
  inCtxt Indx C => spyV 1 "stored" (check Cert' (unfK Rest)).
% initial
check Cert (foc (p A)) :-
  initial_ke Cert Indx,
  spyV 1 "INITIAL" (inCtxt Indx (n A)).
  %,print "INITIAL succeeded \n".
% cut
check Cert (unfK nil) :-
  cut_ke Cert F CertA CertB,
  spyV 1 "negating ?" (negate F NF),
  spyV 1 "left of cut" (check CertA (unfK [F])),
  spyV 1 "right of cut" (check CertB (unfK [NF])).

%%%%%%%%%%%%%%%%%%%%
% Asynchronous Rules
%%%%%%%%%%%%%%%%%%%%

% orNeg
check Cert (unfK [A !-! B | Rest]) :-
  orNeg_kc Cert (A !-! B)  Cert',
  spyV 1 "!-! breaking" (check Cert' (unfK [A, B| Rest])).
% conjunction
check Cert (unfK [A &-& B | Rest]) :-
  andNeg_kc Cert (A &-& B) CertA CertB,
  check CertA (unfK [A | Rest]),
  check CertB (unfK [B | Rest]).
% forall
check Cert (unfK [all B | Theta]) :-
  all_kc Cert Cert',
  pi w\ check (Cert' w) (unfK [B w | Theta] ).
% Units
check Cert (unfK [t-|_]). % No clerk - justify in the paper ?
check Cert (unfK [f-|Gamma]) :-  % Fix the name, between Theta, Teta, Gamma !
  false_kc Cert Cert',
  spyV 1 "f- removing" (check Cert' (unfK Gamma)).
% delay
check Cert (unfK [d- A| Teta]) :-
      check Cert (unfK [A| Teta]).

%%%%%%%%%%%%%%%%%%%
% Synchronous Rules
%%%%%%%%%%%%%%%%%%%
% conjunction
check Cert (foc (A &+& B)) :-
   andPos_ke Cert (A &+& B) CertA CertB,
   spyV 1 "left of &+&" (check CertA (foc A)),
   spyV 1 "right of &+&" (check CertB (foc B)).
% disjunction
check Cert (foc (A !+! B)) :-
  orPos_ke Cert (A !+! B) Choice Cert',
  ((Choice = left,  check Cert' (foc A));
   (Choice = right, check Cert' (foc B))).
% quantifers
check Cert (foc (some B)) :-
  some_ke Cert T Cert',
  spyV 1 "some" (check Cert' (foc (B T))).
% Units
check Cert (foc t+) :-
  spyV 1 "TRUE" (true_ke Cert).
% delay
check Cert (foc (d+ A)) :-
      check Cert (foc A).

%%%%%%%%%%%
% Utilities
%%%%%%%%%%%

isNegForm (_ &-& _).
isNegForm (_ !-! _).
isNegForm (d- _).
isNegForm (all _).
isPosForm (_ &+& _).
isPosForm (d+ _).
isPosForm (_ !+!  _).
isNegAtm (n _).
isPosAtm (p _).
isPosForm (some _).
isPosForm t+.
isPosForm f+.
isNegForm f-.
isNegForm t-.
isNeg A :- isNegForm A ; isNegAtm A.
isPos A :- isPosForm A ; isPosAtm A.
isPosUM A :- isPos A ; isNegAtm A.

negate f- t+.
negate t+ f-.
negate t- f+.
negate f+ t-.

negate (p A) (n A).
negate (n A) (p A).
negate (A &+& B)  (NA !-! NB) &
negate (A !-! B)  (NA &+& NB) &
negate (A &-& B)  (NA !+! NB) &
negate (A !+! B)  (NA &-& NB) :- negate A NA, negate B NB.
negate (all B)  (some NB) &
negate (some B) (all NB) :- pi x\ negate (B x) (NB x).
