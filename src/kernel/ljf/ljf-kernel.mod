% 29 july 2014.
% Paper Fidelity.

module ljf-kernel.

% Entry point
entry_point Cert Form :-
  check Cert (unfJ nil (str- Form)).

%%%%%%%%%%%%%%%%%%
% Structural Rules
%%%%%%%%%%%%%%%%%%

% decide
check Cert (unfJ nil (str+ R)) :-
  decideL_je Cert Indx Cert',
  inCtxt Indx N,
  isNeg N,
  check Cert' (lf N R).
check Cert (unfJ nil (str+ P)) :-
  decideR_je Cert Cert',
  isPos P,
  check Cert' (rf P).

% release
check Cert (lf P R) :-
  isPos P,
  releaseL_je Cert Cert',
  check Cert' (unfJ [P] (str+ R)).
check Cert (rf N) :-
  isNeg N,
  releaseR_je Cert Cert',
  check Cert' (unfJ nil (str- N)).

% store
check Cert (unfJ [C|Rest] Rhs) :-
  (isNeg C ; isPosAtm C),
  storeL_jc Cert C Indx Cert',
  inCtxt Indx C => check Cert' (unfJ Rest Rhs).
check Cert (unfJ nil (str- D)) :-
  (isPos D ; isNegAtm D),
  storeR_jc Cert D Cert',
  check Cert (unfJ nil (str+ D)).

% initial
check Cert (lf Na Na) :-
  isNegAtm Na,
  initialL_je Cert.
check Cert (rf Pa) :-
  isPosAtm Pa,
  initialR_je Cert Indx,
  inCtxt Indx Pa,
  true.

% cut
check Cert (unfJ nil (str+ R)) :-
  cut_je Cert F CertA CertB,
  check CertA (unfJ nil (str- F)),
  check CertB (unfJ [F] (str+ R)).


%%%%%%%%%%%%%%%%%%%%
% Asynchronous Rules
%%%%%%%%%%%%%%%%%%%%

% arrow
check Cert (unfJ nil (str- (A arr B))) :-
  arr_jc Cert (A arr B)  Cert',
  check Cert' (unfJ [A] (str- B)).

% disjunction
check Cert (unfJ [A !! B| Teta] R):-
  or_jc Cert (A !! B) CertA CertB,
  check CertA (unfJ [A | Teta] R),
  check CertB (unfJ [B | Teta] R).

% conjunction
check Cert  (unfJ [A &+& B | Teta] R) :-
  andPos_jc Cert (A &+& B) Cert',
  check Cert' (unfJ [A , B | Teta] R).
check Cert (unfJ nil (str- (A &-& B))) :-
  andNeg_jc Cert (A &-& B) CertA CertB,
  check CertA (unfJ nil (str- A)),
  check CertB (unfJ nil (str- B)).

% quantifers
check Cert (unfJ [some B | Theta] R) :-
  some_jc Cert Cert',
  pi w\ check (Cert' w) (unfJ [B w | Theta] R).
check Cert (unfJ nil (str- (all B))) :-
  all_jc Cert Cert',
  pi w\ check (Cert' w) (unfJ nil (str- (B w))).

% Units
check Cert (unfJ [f| Theta] R).
check Cert (unfJ [t| Theta] R) :-
  true_jc Cert Cert',
  check Cert' (unfJ Theta R).

% delay
check Cert  (unfJ [d+ A| Teta] R) :-
  d+_jc Cert Cert',
  check Cert  (unfJ [A| Teta] R).
check Cert  (unfJ nil (str- (d- R))) :-
  d-_jc Cert Cert',
  check Cert'  (unfJ nil (str- R)).

%%%%%%%%%%%%%%%%%%%
% Synchronous Rules
%%%%%%%%%%%%%%%%%%%

% arrow
check Cert (lf (A arr B) R) :-
  arr_je Cert (A arr B) CertA CertB,
  check CertA (rf A),
  check CertB (lf B R).

% disjunction
check Cert (rf (A !! B)) :-
  or_je Cert (A !! B) Choice Cert',
  ((Choice = left,  check Cert' (rf A));
   (Choice = right, check Cert' (rf B))).

% conjunction
check Cert (rf (A &+& B)) :-
  andPos_je Cert (A &+& B) CertA CertB,
  check CertA (rf A),
  check CertB (rf B).
check Cert (lf (A &-& B) R) :-
  andNeg_je Cert (A &-& B) Choice Cert',
  ((Choice = left,  check Cert' (lf A R));
   (Choice = right, check Cert' (lf B R))).

% quantifers
check Cert (rf (some B)) :-
  some_je Cert T Cert',
  check Cert' (rf (B T)).
check Cert (lf (all B) R) :-
  all_je Cert T Cert',
  check (Cert') (lf (B T) R).

% Units
check Cert (unfJ [f| Theta] R).
check Cert (unfJ [t| Theta] R) :-
  true_jc Cert Cert',
  check Cert' (unfJ Theta R).

% delay
check Cert (rf (d+ A)) :-
     check Cert (rf A).
check Cert (lf (d- A) R) :-
     check Cert (lf A R) .

%%%%%%%%%%%%%%%%%%%
% Units
check Cert (rf t) :-
  true_je Cert.

% delay
check Cert (rf (d+ A)) :-
      d+_je Cert Cert',
      check Cert' (rf A).
check Cert (lf (d- A) R) :-
      d-_je Cert Cert',
      check Cert' (lf (A) R).

%%%%%%%%%%%
% Utilities
%%%%%%%%%%%
isPosForm t.
isPosForm f.
isNegForm (_ &-& _).
isNegForm (_ arr _).
isNegForm (d- _).
isNegForm (all _).
isPosForm (some _).
isPosForm (_ &+& _).
isPosForm (d+ _).
isPosForm (_ !!  _).
isNegAtm (n _).
isPosAtm (p _).
isNeg A :- isNegForm A ; isNegAtm A.
isPos A :- isPosForm A ; isPosAtm A.
