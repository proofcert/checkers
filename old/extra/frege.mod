module frege.
accumulate ljf-kernel.

% in order of appearance
storeR_jc X _ X. % remember, take away all non constructor certs.
% If just instanciation.
decideL_je (frgC [inst I Inst NextIndx|Tail]) (idf I) 
	   (wit Inst (strC NextIndx (frgC Tail))).
all_je (wit [W|Tail] Cert) W (wit Tail Cert).
releaseL_je (wit [] Cert) Cert.
storeL_jc (strC I Cert) _ (idf I) Cert.
% If MP application
% After a thought, should keep endWith, that's what will instanciate logic variables. 
decideL_je (frgC [mp I L R Next|Tail]) (idf I) 
	   (mpC (antC (endWith L)(endWith R)) (strC Next (frgC Tail))).
all_je (mpC L R) _ (mpC L R).
arr_je (mpC L R) _ L R.
  % Left arrow left premise
andPos_je (antC L R) _ L R.
initialR_je (endWith I) (idf I).
  % Left arrow RIGHT premise
releaseL_je (strC N C) (strC N C).

    

%decideR_je (endWith I) (endWith I).
decideR_je (frgC []) endCert.
initialR_je endCert _.




/* Testing */
gam 1 (all x\ all y\ p (frg(x $> y $> x))).
gam 2 (all a\ all b\ all c\ p (frg((a $> b $> c) $> (a $> b) $> a $> c))).
gam 3 (all a\ all b\ (p (frg a) &+& p (frg(a $> b))) arr p (frg b)).

eg 1 [1,2,3] (frgC [inst 2 [oa, oa $> oa, oa] 4, 
     	     	   inst 1 [oa, oa $> oa] 5, 
		   mp 3 5 4 6,
		   inst 1 [oa, oa] 7,
		   mp 3 7 6 8]) (p (frg (oa $> oa))) .
eg 2 [1] (frgC [inst 1 [oa, ob] 4]) (p (frg (oa $> ob $> oa))).

storeInit [] Cert Goal 	      :- entry_pointLJF Cert Goal.
storeInit [I|Tail] Cert Goal :-
   gam I F,
   inCtxt (idf I) F => storeInit Tail Cert Goal.
  
testfrg I :- 
   eg I Init Cert Goal, 
   storeInit Init Cert Goal.
