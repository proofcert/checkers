% 29 july 2014.
module lmf-kernel.
accumulate lists.

% Entry point
entry_point Cert Form :-
  check Cert (unfK [Form]).

%%%%%%%%%%%%%%%%%%
% Structural Rules
%%%%%%%%%%%%%%%%%%

% decide
check Cert (unfK nil) :-
  decide_ke Cert Indx Cert',
  inCtxt Indx P,
  isPos P,
  check Cert' (foc P).
% release
check Cert (foc N) :-
  isNeg N,
  release_ke Cert Cert',
  check Cert' (unfK [N]).
% store
check Cert (unfK [C|Rest]) :-
  (isPos C ; isNegAtm C),
  store_kc Cert C Indx Cert',
  inCtxt Indx C => check Cert' (unfK Rest).
% initial
check Cert (foc (lform L (p A))) :-
  initial_ke Cert Indx,
  inCtxt Indx (lform L (n A)).
% cut
check Cert (unfK nil) :-
  cut_ke Cert (lform L F) CertA CertB,
  negateForm F NF,
  check CertA (unfK [lform L F]),
  check CertB (unfK [lform L NF]).

%%%%%%%%%%%%%%%%%%%%
% Asynchronous Rules
%%%%%%%%%%%%%%%%%%%%

% orNeg
check Cert (unfK [lform L (A !-! B) | Rest]) :-
  orNeg_kc Cert (lform L (A !-! B))  Cert',
  check Cert' (unfK [lform L A, lform L B| Rest]).
% conjunction
check Cert (unfK [lform L (A &-& B) | Rest]) :-
  andNeg_kc Cert (lform L (A &-& B)) CertA CertB,
  check CertA (unfK [lform L A | Rest]),
  check CertB (unfK [lform L B | Rest]).
% box
check Cert (unfK [lform L (box B) | Theta]) :-
  box_kc Cert I Cert',
  pi w\ inCtxtRel I (relation L w) =>  (check (Cert' w) (unfK [lform w B | Theta] )).
% Units
check Cert (unfK [lform _ t-|_]). % No clerk - justify in the paper ?
check Cert (unfK [lform _ f-|Gamma]) :-  % Fix the name, between Theta, Teta, Gamma !
  false_kc Cert Cert',
  check Cert' (unfK Gamma).

%%%%%%%%%%%%%%%%%%%
% Synchronous Rules
%%%%%%%%%%%%%%%%%%%
% conjunction
check Cert (foc (lform L (A &+& B))) :-
   andPos_kc Cert (lform L (A &+& B)) Direction CertA CertB,
   ((Direction = left-first,
   check CertA (foc (lform L A)),
   check CertB (foc (lform L B)));
   (Direction = right-first,
   check CertB (foc (lform L B)),
   check CertA (foc (lform L A)))).
% disjunction
check Cert (foc (lform L (A !+! B))) :-
  orPos_ke Cert (lform L (A !+! B)) Choice Cert',
  ((Choice = left, check Cert' (foc (lform L A)));
  (Choice = right, check Cert' (foc (lform L B)))).
% diamond
check Cert (foc (lform L (dia B))) :-
  dia_ke Cert I Cert',
	inCtxtRel I (relation L L'),
  check Cert' (foc (lform L' B)).
% Units
check Cert (foc i(lform _ t+)) :-
  true_ke Cert.

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


/* Temporary : for backwards compatibility.
Once the andPos_ke has been changed everywhere, andPos_k can be changed to andPos_ke,
for now andPos_k calls on andPos_ke.
*/

andPos_k Cert (A &+& B) left-first CertA CertB :-
   andPos_ke Cert (A &+& B) CertA CertB.
