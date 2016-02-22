module tableaux.

move_to_front L1 A [(delta A X B)|L2] :- memb_and_rest (delta A X B) L1 L1bis, move_to_front L1bis B L2.
move_to_front L1 A [(gamma A B)|L2] :- memb_and_rest (gamma A B) L1 L1bis, move_to_front L1bis B L2.
move_to_front L1 A [(alpha A B C)|L2] :- memb_and_rest (alpha A B C) L1 L1bis, move_to_front L1bis C L1bisbis, move_to_front L1bisbis B L2.
move_to_front L1 A [(beta A B C)|L2] :- memb_and_rest (beta A B C) L1 L1bis, move_to_front L1bis C L1bisbis, move_to_front L1bisbis B L2.
move_to_front L1 A L1.
move_to_front [] _ [].


elim L1 A L2 :- memb_and_rest (delta A X B) L1 L1bis, elim L1bis B L2.
elim L1 A L2 :- memb_and_rest (gamma A B) L1 L1bis, elim L1bis B L2.
elim L1 A L2 :- memb_and_rest (alpha A B C) L1 L1bis, elim L1bis C L1bisbis, elim L1bisbis B L2.
elim L1 A L2 :- memb_and_rest (beta A B C) L1 L1bis, elim L1bis C L1bisbis, elim L1bisbis B L2.
elim L1 A L1.
elim [] _ [].

%diff_branches A B Z :- member (back X L) Z => (not (member A L, member B L)).

%--- OR ---%
%TODO: move to the front of the list whenever we act on this not on the front.
orNeg_kc (tabp CER1 D S Z) (FOR1 !-! FOR2) (tabp CER2 D S Z) :-
	 mapsto A (FOR1 !-! FOR2),
	 mapsto B FOR1,
	 mapsto C FOR2,
	 memb_and_rest (alpha (idx A) (idx B) (idx C)) CER1 CER2.
orNeg_kc CERT _ CERT.

%--- AND ---%
andPos_ke (tabp [(beta (idx A) (idx B) (idx C))|T] D S Z) (FOR1 &+& FOR2) (tabp TB D S Z) (tabp TC D S Z) :-
	 mapsto A (FOR1 &+& FOR2),
	 mapsto B FOR1,
	 mapsto C FOR2,
	 elim T (idx C) TB,
	 elim T (idx B) TC.

%This line should be useless as we make sure that in focused mode, the right decisions are on the front.
%andPos_ke (tabp CER1 D S Z) (FOR1 &+& FOR 2) (tabp CER2A D S Z) (tabp CER2B D S Z) :- mapsto A (FOR1 &+& FOR2), mapsto B FOR1, mapsto C FOR2, memb_and_rest (beta (idx A) (idx B) (idx C)) CER1 CER2, elim CER2 (idx B) CER2A, elim CER2 (idx A) CER2B.


%--- STORE ---%
store_kc (tabp A B S Z) C1 (idx I) (tabp A B S Z) :- mapsto I C1.

%--- ALL ---%
all_kc (tabp [(delta A B C)|T] D S Z) B (x\ (tabp T D [(assoc x B)|S] Z )).
all_kc (tabp L D S Z) B (x\ (tabp L1 D [(assoc x B)|S] Z )) :- memb_and_rest (delta A B C) L L1.


%--- FOCUS ---%
%The focus rule is the most important : We have to check that we are going to focus on clauses that don't make existential quantifier appear before universal one.
%This line has to be changed because it is strongly inefficient, but it does the right thing. To be commented to make hahnle_example working.



%Now that we are sure, we can focus on the first rule
decide_ke (tabp [(gamma A C)|T1] L S Z) A (tabp [(gamma A C)|T1] L S Z).
decide_ke (tabp [(beta A B C)|T1] L S Z) A (tabp [(beta A B C)|T1] L S Z).

decide_ke (tabp Cert L S Z) B (tabp Cert_perm L S Z) :- member (beta B E F) Cert, move_to_front Cert B Cert_perm.
decide_ke (tabp Cert L S Z) B (tabp Cert_perm L S Z) :- member (gamma B E)  Cert, move_to_front Cert B Cert_perm.

decide_ke (tabp M C L Z) A (tabp M C L Z) :- member (closure A _ _) C.
decide_ke (tabp M C L Z) B (tabp M C L Z) :- member (closure _ B _) C.

%--- SOME ---%
some_ke (tabp [(gamma C A)|T1] CLOS S Z) ATM2 (tabp T1 CLOS S Z) :- member (closure X Y [ATM|T3]) CLOS, member (back X L) Z, member A L, replace_back ATM S ATM2.
some_ke (tabp [(gamma C A)|T1] CLOS S Z) ATM2 (tabp T1 CLOS S Z) :- member (closure X Y [ATM|T3]) CLOS, member (back Y L) Z, member A L, replace_back ATM S ATM2.

some_ke (tabp [(gamma C B)|T1] [(closure A B [ATM|T3])|T2] S Z) ATM (tabp  T1 [(closure A B T3)|T2] S Z).
some_ke (tabp [(gamma C A)|T1] [(closure A B [ATM|T3])|T2] S Z) ATM (tabp  T1 [(closure A B T3)|T2] S Z).

%--- AXIOM ---%
initial_ke (tabp L1 L S Z) A :- member (closure A _ _) L.
initial_ke (tabp L1 L S Z) A :- member (closure _ A _) L.

%--- RELEASE ---%
release_ke C C.
