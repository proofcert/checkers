module fittings-tableaux.

decide_ke 


(*decide_ke (labcert [A|Gamma]) (labindex A) (labcert Gamma). %
release_ke (labcert Gamma) (labcert Gamma).
store_kc (labcert Gamma) A (labindex A) (labcert C). %
initial_ke (labcert Gamma) _.
all_kc (labcert Gamma) (_ Gamma).
%some_ke (labcert [T|Tail]) T (labcert Tail). %
%some_ke (labcert [T|Tail]) (p q !-! n r) (labcert Tail).
orNeg_kc (labcert Gamma) _ (labcert Gamma).

labcheck A Gamma :-
  if (entry_point (labcert Gamma) A)
      (print "Success\n==============================================\n")
		  (print "Failure\n", halt), fail.


%type decide_ke					cert -> index -> cert -> o.
%type release_ke 				cert -> cert -> o.
     
%type store_kc					cert -> form -> index -> cert -> o.
%type initial_ke					cert -> index -> o.
%type all_kc					cert -> (A -> cert) -> o.
%type some_ke					cert -> A -> cert -> o.
%type andNeg_kc,	 andPos_ke			cert -> form -> cert -> cert -> o.
%type andPos_k	 				cert -> form -> direction -> cert -> cert -> o.
%type orNeg_kc 	 				cert -> form -> cert -> o.
%type orPos_ke    	    			cert -> form -> choice -> cert -> o.
%type true_ke 					cert -> o.
%type false_kc 					cert -> cert -> o.





true_ke (fittab _).
release_ke (fittab L) (fittab L).

eigencopy [] [].
eigencopy ([X|Ls] [X'|Ls'] :- eigencopy(X,X'), eigencopy(Ls,Ls').*)
