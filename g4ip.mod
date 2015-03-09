module g4ip.
accumulate mimic, lists.

% Change clerc X X to actual constructor, for protection. 

% Left branch of a cut : In order of appearance
% Li is the index of the principle formula of the dyck rule 

arr_jc (infer4 A [] [R]) _ (infer4 A [<< R] [>> R]).
storeL_jc (infer4 A [L] R) _ L' (infer4 A [] R) :-
   changeIndex Corresponds,
   member (pr L L') Corresponds.
storeR_jc (infer4 (one A) L [R]) _ (infer4 (one A) L []).
decideL_je (infer4 (one I2Rwt) [] []) I2Rwt (infer4 none [$l] []).
arr_je (infer4 none [I] []) _ 
       (infer4 none [] [<< I])
       (infer4 none [>> I] []).
% right premise :
releaseL_je (infer4 none [L] []) (mim (one Root) [Root] [] Root) :-
   changeIndex Corresponds,
   member (pr L Root) Corresponds.
% left premise : 
releaseR_je (infer4 A [] [R]) (infer4 A [] [R]).
% arrow clerk still works.
% storeLclerk still works
storeR_jc (infer4 none [] [R]) _ (infer4 (one R') [] [PlaceHolder]) :-
   changeIndex Corresponds,
   member (pr R R') Corresponds.
% Now the uglyness : decide on the one that releases right away.
% Must do a very small (just a dealy peal) before releasing. 
decideL_je (infer4 (one R') [] [PlaceHolder]) R' (oneStep R' ).
releaseL_je (oneStep R') (mim (one R') [R'] [] R').
decideR_je (infer4 (one R') [] [PlaceHolder]) (oneStep R' ).
releaseR_je (oneStep R') (mim (one R') [R'] [] R').

%storeL_jc 
/*
type mim option -> list index -> list index -> index -> cert.
type >> index -> index.
type << index -> index.
type $  index.

type decideL_je                                 cert -> index -> cert -> o.
type decideR_je, releaseL_je, releaseR_je               cert -> cert -> o.
     
type storeL_jc                                  cert -> form -> index -> cert -> o.
type storeR_jc                                  cert -> form -> cert -> o.
type initialL_je                                        cert -> o.
type initialR_je                                        cert -> index -> o.
type arr_jc, 						cert -> form -> cert -> o.
type arr_je						cert -> form -> cert -> cert -> o.
type cut_je cert -> form -> cert -> cert -> o.
*/

changeIndex [pr (>> $r)	     ($1), 
	     pr (<< $r)      ($2),
	     pr (>> $l)      ($1),
	     pr (>> (<< $l)) ($2),
	     pr (<< (<< $l)) ($l) % unused
	     ].
insertDelays (p A) (p A).
insertDelays (n A) (n A).
insertDelays (A arr B) (d- (A') arr d+ (B')) :- insertDelays A A', insertDelays B B'.
