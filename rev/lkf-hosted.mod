module lkf-hosted.
accumulate ljf-kernel.
accumulate spy.

lkf_entry Cert CForm :- trans- CForm IForm, ljf_entry Cert (IForm arr (n fatom)).

trans+ f+ f.
trans+ t+ t+.
trans+ (p A)     (p A).
trans+ (A !+! B) (A' !+!  B') & 
trans+ (A &+& B) (A' &+& B') :- trans+ A A', trans+ B B'.
trans+ (some B)  (some B')   :- pi x\ trans+ (B x) (B' x).
trans+ N         (N' arr (n fatom)) :-  isNeg N, trans- N N'.

trans- f- t+.
trans- t- f.
trans- (n A)      (p A).
trans- P          (P' arr (n fatom))  :- isPos P, trans+ P P'.
trans- (A !-! B)  (A' &+& B') &
trans- (A &-& B)  (A' !+! B') :- trans- A A', trans- B B'.
trans- (all B)    (some B')   :-  pi x\ trans- (B x) (B' x).

% Now define the intuitionistic versions of the clecks and experts
% to simply call the classical versions.
/* redefine */
andPos_jc   C C'        :- orNeg_kc   C C'.
andPos_je   C C' C''    :- andPos_ke  C C' C''.
decideL_je  C C' I      :- decide_ke  C C' I.
initialR_je C I         :- initial_ke C I.
or_jc       C C' C''    :- andNeg_kc  C C' C''.
or_je       C C' Choice :- orPos_ke   C C' Choice.
releaseR_je C C'        :- release_ke C C'.
some_jc     C C'        :- all_kc     C C' .
some_je     C C' T      :- some_ke    C C' T.
storeL_jc   C C' I      :- store_kc   C C' I.
true_jc     C C'        :- false_kc   C C'.
true_je     C           :- true_ke    C.
arr_jc      C C.
storeR_jc   C C.
arr_je      C C  fcert.
initialL_je fcert.
/* end */
  % Missing in Zak's implementation
% releaseL_je fcert fcert.

%cut_je cert -> form -> cert -> cert -> o.
/* cut */
cut_je C C1 C2 F :- cut_ke C C1 C2 N, isNeg N, negate N P, trans- P F.
cut_je C C2 C1 F :- cut_ke C C1 C2 P, isPos P,             trans- P F.
/* end */
% Notice we're using it in reverse : a lot better and safer to actually write a reversed version

%There is no initialL_je, each decide on the left is on the arrow, the arrow
% Is always followed by a false, the false is always released and the proof
% ends not with initial but with the false rule

% only release on the left if focus in on false

%No decideR_je since we only have "false" stored on the right.
% The only formula to store on the right is f ?



