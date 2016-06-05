%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% modlean_dec_s4.pl
% 
% Sicstus Prolog
% Copyright (C) 1998: Bernhard Beckert (University of Karlsruhe) and 
%                     Rajeev Gore (Australian National University)
%                     Email: beckert@ira.uka.de, rajeev.gore@arp.anu.edu.au
%
% Purpose:            Tableau-based theorem prover for NNF formulae
%                     of the propositional modal logic S4
%                     Version 2.0, Decision procedure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- module(modlean_dec_s4,[decprove_s4/1]).

:- op(400,fy,box), 
   op(400,fy,dia).

:- use_module(library(lists),[member/2,reverse/2,append/3]).

% -----------------------------------------------------------------
% decprove_s4(+Fml)
%
% Succeeds if there is a closed tableau for Fml and fails otherwise.
%
% Fml is a formula of propositional modal logic, i.e., the 
% logical operators `-' (negation), `,' (conjunction), 
% `;' (disjunction), box (box operator), and dia (diamond operator)
% may be used, where `-' only occurs on the atomic level.

decprove_s4(Fml) :-
	prove(Fml,[(1,1)],[],[],[],[],[],[],[],[],[],[],[],[]).


% prove(Fml,Label,Univ,Inst,Lits,UnExp,Sleep,Free,Forbid)
%
% Fml: The current formula.
% Label: The label of the current formula
% Univ: The list of universal variables in the curren formula
% Inst: Instantiations of previous copies of the formula
% Lits: The set of literals that have not been used yet to be unified
%       with the current formula to close the current branch
% UnExp: The set of formulae that have not been considered yet
% Sleep: Formulae that have been put asleep
% Free: A list of the variables introduced in labels (can be instantiated)
% Forbid: A list of triples; the first element is a variable, the second is a 
%         list of terms; the third is a flag used in the evaluation. 
%         These are constraints: the first element must not be instaniated 
%         with an element of the list.
%
% In Lits literals are stored in the form
% (Label:Negation), where Negation is the complement of the literal
%
% Inst is a list of lists. It contains for each of the variables in 
% Univ a list of previous instantiations the variable.
%
% In UnExp formulae are stored in the form (Univ:Inst:Label:Fml)
%
% In Sleep formulae are stored in the form (Univ:Inst:Label:Fml)-Vars, where
% at least one of the variables in Vars must be instaniated (i.e., Vars is 
% a list that has to contain at least one ground atom for the 
% formula to be waken up.


% The conjunctive rule

prove((A,B),Label,Univ,Inst,Lits,UnExp,Sleep,Free,Forbid,AllLabels,
      UsedD,BlockedD,NewB,UnjustB) :- !,
        copy_term((Label,Univ,Free),(LabelB,UnivB,Free)),
        prove(A,Label,Univ,Inst,Lits,
              [(UnivB:Inst:LabelB:B)|UnExp],Sleep,Free,Forbid,AllLabels,
              UsedD,BlockedD,NewB,UnjustB).


% The disjunctive rule

prove((A;B),Label,Univ,Inst,Lits,UnExp,Sleep,Free,Forbid,AllLabels,
      UsedD,BlockedD,NewB,UnjustB) :- !,
        copy_term((Label,Univ,Free),(LabelA,UnivA,Free)),
        copy_term((Label,Univ,Free),(LabelB,UnivB,Free)),
        extend_inst(Univ,Inst,NewInst),
        make_forbid(Univ,Inst,AddForbid),
        append(AddForbid,Forbid,NewForbid),
        append(Sleep,[(UnivA:NewInst:LabelA:(A;B))-Univ],SleepA),
        append(Sleep,[(UnivB:NewInst:LabelB:(A;B))-Univ],SleepB),
        prove(A,Label,[],[],Lits,UnExp,SleepA,(Univ+Free),NewForbid,
              AllLabels,UsedD,BlockedD,NewB,UnjustB),
        prove(B,Label,[],[],Lits,UnExp,SleepB,(Univ+Free),NewForbid,
              AllLabels,UsedD,BlockedD,NewB,UnjustB).


% all the box formulas are assumed to be unjustified first

prove(box Fml,Label,Univ,Inst,Lits,UnExp,Sleep,Free,Forbid,AllLabels,
      UsedD,BlockedD,NewB,UnjustB) :- !,
   prove(expand,_,_,_,Lits,UnExp,Sleep,Free,Forbid,AllLabels,
      UsedD,BlockedD,NewB,[(Univ:Inst:Label:(box Fml))|UnjustB]).


% all dia formulas are blocked at first.

prove(dia Fml,Label,Univ,Inst,Lits,UnExp,Sleep,Free,Forbid,AllLabels,
      UsedD,BlockedD,NewB,UnjustB) :- !,
   prove(expand,_,_,_,Lits,UnExp,Sleep,Free,Forbid,AllLabels,
      UsedD,[(Univ:Inst:Label:(dia Fml))|BlockedD],NewB,UnjustB).



% Use a new formula from UnExp

prove(expand,_,_,_,Lits,[(Univ:Inst:Label:Fml)|UnExpR],Sleep,Free,Forbid,
      AllLabels,UsedD,BlockedD,NewB,UnjustB) :- !,
	prove(Fml,Label,Univ,Inst,Lits,UnExpR,Sleep,Free,Forbid,
              AllLabels,UsedD,BlockedD,NewB,UnjustB).


% Look for a dia formula in BlockedD that is not blocked and apply dia rule

prove(expand,_,_,_,Lits,[],Sleep,Free,Forbid,
      AllLabels,UsedD,BlockedD,NewB,UnjustB) :-
        dia_unblocked(UsedD,BlockedD,NewB,
                      (Univ:Inst:Label:dia Fml),RestBlockedD),
    	!,
	reverse([(Fml,Fml)|Label],TmpNewLabel),
        append(TmpNewLabel,_,NewLabel),
        prove(Fml,[(Fml,Fml)|Label],Univ,Inst,Lits,[],Sleep,Free,Forbid,
              [NewLabel|AllLabels],              
              [(Fml:Label:Univ)|UsedD],RestBlockedD,NewB,UnjustB).


% Wake up (if possible) a formula from Sleep

prove(expand,_,_,_,Lits,[],Sleep,Free,Forbid,AllLabels,
      UsedD,BlockedD,NewB,UnjustB) :-
	wake_up(Sleep,(Univ:Inst:Label:Fml),SleepR),
	!,
	prove(Fml,Label,Univ,Inst,Lits,[],SleepR,Free,Forbid,AllLabels,
	      UsedD,BlockedD,NewB,UnjustB).


% Look for a box formula in UnjustB that is justified and apply the box rule

prove(expand,_,_,_,Lits,[],Sleep,Free,Forbid,AllLabels,
      UsedD,BlockedD,NewB,UnjustB) :-
	justified_box(AllLabels,UnjustB,(Univ:Inst:Label:box Fml),RestUnjustB),
	!,
	copy_term((Label,Univ,Free),(LabelT,UnivT,Free)),
	copy_term((Label,Univ,Free),(Label4,Univ4,Free)),
        (  new_box(Fml,Label,Univ,NewB) ->
           NewNewB = [(Fml:Label:Univ)|NewB]
        ;  NewNewB = NewB
        ),
        prove(Fml,[(X,_)|Label],[X|Univ],[[]|Inst],Lits,
              [(UnivT:Inst:LabelT:Fml)],Sleep,Free,Forbid,AllLabels,
              UsedD,BlockedD,NewNewB,
              [([Y|Univ4]:[[]|Inst]:[(Y,_)|Label4]:(box Fml))|RestUnjustB]).


% Try to use the current literal for closure

prove(Lit,Label,_,_,[L|Lits],_,_,Free,Forbid,_,_,_,_,_) :-
	Lit \== expand,
        copy_term(((Label:Lit),Free),(New,Free)),
        (    copy_term((L,Free),(New,Free)),
             check_forbid(Forbid)
        ;    prove(Lit,Label,_,_,Lits,do_not_expand,[],Free,Forbid,_,_,_,_,_)
        ).


% Do not use the current literal for closure

prove(Lit,LitLabel,_,_,Lits,UnExp,Sleep,Free,Forbid,AllLabels,
      UsedD,BlockedD,NewB,UnjustB) :-
	Lit \== expand,
        UnExp \== do_not_expand,
	!,
    	( (Lit = -Neg; -Lit = Neg) ->
  	  prove(expand,_,_,_,[(LitLabel:Neg)|Lits],UnExp,Sleep,Free,Forbid,
                AllLabels,UsedD,BlockedD,NewB,UnjustB)
        ).

%prove(Fml,Label,Univ,Inst,Lits,[],SleepR,Free,Forbid,AllLabels,
%	      UsedD,BlockedD,NewB,UnjustB) :-
%write(prove(Fml,Label,Univ,Inst,Lits,[],SleepR,Free,Forbid,AllLabels,
%	      UsedD,BlockedD,NewB,UnjustB)),fail.


prove(Fml,Label,Univ,Inst,Lits,[],SleepR,Free,Forbid,AllLabels,
	      UsedD,BlockedD,NewB,UnjustB) :-
write(backtrack),fail.


% ADDITIONAL PREDICATES

% wake_up(+Sleep,-Fml,-RestSleep)
%
% Looks for the first formula in Sleep than can be waken up. 
% It is returned in Fml, all other formulae in Sleep are returned in 
% the list RestSleep.

wake_up([(Fml-Vars)|Sleep],Fml,Sleep) :- 
	contains_ground(Vars),
	!.

wake_up([First|Sleep],Fml,[First|RestSleep]) :- 
	wake_up(Sleep,Fml,RestSleep).

contains_ground([H|_]) :- \+(var(H)),!.
contains_ground([_|T]) :- contains_ground(T).



% extend_inst(+Vars,+Inst,-NewInst)
%
% Vars and Inst are lists of the same length. Each element of 
% Vars are added at front to the corresponding element of Inst.

extend_inst([FirstV|RestV],[FirstI|RestI],[[FirstV|FirstI]|Rest]) :-
    	extend_inst(RestV,RestI,Rest).

extend_inst([],[],[]).


% make_forbid(+Vars,+Inst,-Forbid)
%
% Vars and Inst are lists of the same length. A list of forbid-triples
% of the same length is constructed

make_forbid([FirstU|RestU],[FirstI|RestI],[(FirstU,FirstI,_)|Rest]) :-
    	make_forbid(RestU,RestI,Rest).

make_forbid([],[],[]).



% check_forbid(+Forbid)
%
% Checks a list of forbid-triples. Fails if in one of the triples 
% (Var,Inst,Label) the variable Var 
% is instantiated with an element of the list Inst. If Label is non-ground,
% then the triple is ok and does not have to be tested (again).


check_forbid([(Var,Inst,Flag)|Rest]) :-
	(  (ground(Var), var(Flag)) ->
           \+(member(Var,Inst)),
           Flag = true
        ;  true
        ),
        check_forbid(Rest).

check_forbid([]).



new_box(Fml,Label,Univ,NewB) :-
	reverse(Label,RevLabel),
   	\+( ( member((Fml:OldLabel:OldUniv),NewB),
	      reverse(OldLabel,RevOldLabel),
              ipr_ident(RevOldLabel,OldUniv,RevLabel,Univ)
          ) ).

ipr_ident([(TauF,_)|TauR],UnivTau,[(SigmaF,_)|SigmaR],UnivSigma) :-
 	(  TauF == SigmaF
        ;  occurs_in(TauF,UnivTau)
        ;  occurs_in(SigmaF,UnivSigma)
        ),
        !,
        ipr_ident(TauR,UnivTau,SigmaR,UnivSigma).

ipr_ident([],_,_,_).

ipr_unif([First|TauR],[First|SigmaR]) :-
        ipr_unif(TauR,SigmaR).

ipr_unif([],_).


occurs_in(X,[H|_]) :-
	X == H,
        !.

occurs_in(X,[_|T]) :-
	occurs_in(X,T).


justified_box(AllLabels,[(Univ:Inst:Label:Fml)|Rest],
              (Univ:Inst:Label:Fml),Rest) :-
	reverse(Label,RevLabel),
	\+(\+(justified(RevLabel,AllLabels))),
 	!.

justified_box(AllLabels,[H|T],Fml,[H|RestT]) :-
	justified_box(AllLabels,T,Fml,RestT).
	


% justified(+Label,+AllLab)
%
% Checks whether Label is justified by the list AllLab of labels.

justified(Label,_) :- ground(Label).

justified(Label,[Label|T]) :- justified(Label,T),!.
	
justified(Label,[_|T]) :- justified(Label,T),!.


dia_unblocked(UsedD,[(Univ:Inst:Label:dia Fml)|RestBlockedD],NewB,
              (Univ:Inst:Label:dia Fml),RestBlockedD) :-
	reverse(Label,RevLabel),
	\+( ( member((Fml:TauLabel:TauUniv),UsedD),
	      reverse(TauLabel,RevTauLabel),
	      ipr_ident(RevTauLabel,TauUniv,RevLabel,Univ),
	      \+( ( member((_:TauPrimeLabel:_),NewB),
		    reverse(TauPrimeLabel,RevTauPrimeLabel),
 		    ipr_unif(RevTauLabel,RevTauPrimeLabel),
                    ipr_unif(RevTauPrimeLabel,RevLabel)
                ) )
          ) ),
        !.

dia_unblocked(UsedD,[H|T],NewB,Fml,[H|RestT]) :-
	dia_unblocked(UsedD,T,NewB,Fml,RestT).

