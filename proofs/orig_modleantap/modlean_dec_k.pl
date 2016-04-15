%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% modlean_dec_k.pl
% Sicstus Prolog
% Copyright (C) 1998: Bernhard Beckert (University of Karlsruhe) and 
%                     Rajeev Gore (Australian National University)
%                     Email: beckert@ira.uka.de, rajeev.gore@arp.anu.edu.au
%
% Purpose:            Tableau-based theorem prover for NNF formulae
%                     of the propositional modal logic K
%                     Version 2.0, Decision procedure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- module(modlean_dec_k,[decprove_k/1]).

:- op(400,fy,box), 
   op(400,fy,dia).

:- use_module(library(lists),[reverse/2,append/3,member/2]).
	
% -----------------------------------------------------------------
% decprove_k(+Fml)
%
% Succeeds if there is a closed tableau for Fml and fails otherwise.
%
% Fml is a formula of propositional modal logic, i.e., the 
% logical operators `-' (negation), `,' (conjunction), 
% `;' (disjunction), box (box operator), and dia (diamond operator)
% may be used, where `-' only occurs on the atomic level.

decprove_k(Fml) :-
	prove(Fml,[1],[],[],[],[],[],[],[],[],[],[]).


% prove(Fml,Label,Univ,Inst,Lits,AllLits,UnExp,Sleep,AllLab,NonGrd,Free,Forbid)
%
% Fml: If it is _not_ a Prolog list, it is the current formula. If it is
%      a Prolog list, it is a list of closures that could not be made ground
%      before, but should be checked again at this point. A closure is of the
%      form ((Label1:Lit1),(Label2,Neg2),Rev), where Neg2 is the negation of 
%      the  second literal Lit2 and Rev is the label Label1 reversed.
% Label: The label of the current formula.
% Univ: The list of universal variables in the curren formula.
% Inst: Instantiations of previous copies of the formula
% Lits: The set of literals that have not been used yet to be unified
%       with the current formula to close the current branch.
% AllLits: The set of all literals on the branch.
% UnExp: The set of formulae that have not been considered yet.
% Sleep: Formulae that have been put asleep.
% AllLab: A list of all the labels on the current branch that have
%         been introduced by a diamond rule application; a label [1,2,3]
%         is stored as [3,2,1|_] (with an open tail).
% NonGrd: These are closures of the branch that up to now could not
%         be shown to be justified.
% Free: A list of the variables introduced in labels (can be instantiated).
% Forbid: A list of triples; the first element is a variable, the second is a 
%         list of terms; the third is a flag used in the evaluation. 
%         These are constraints: the first element must not be instaniated 
%         with an element of the list.
%
% In both Lits and AllLits, literals are stored in the form
% (Label:Negation), where Negation is the complement of the literal.
%
% Inst is a list of lists. It contains for each of the variables in 
% Univ a list of previous instantiations the variable.
%
% In UnExp formulae are stored in the form (Univ:Inst:Label:Fml).
%
% In Sleep formulae are stored in the form (Univ:Inst:Label:Fml)-Vars, where
% Vars is a list that has to contain at least one ground atom, for the 
% formula to be waken up.


% The conjunctive rule

prove((A,B),Label,Univ,Inst,_,AllLits,UnExp,Sleep,AllLab,
      NonGrd,Free,Forbid) :- !,
        copy_term((Label,Univ,Free),(LabelB,UnivB,Free)),
        prove(A,Label,Univ,Inst,AllLits,AllLits,[(UnivB:Inst:LabelB:B)|UnExp],
              Sleep,AllLab,NonGrd,Free,Forbid).


% The disjunctive rule

prove((A;B),Label,Univ,Inst,_,AllLits,UnExp,Sleep,AllLab,
      NonGrd,Free,Forbid) :- !,
	copy_term((Label,Univ,Free),(LabelA,UnivA,Free)),
        copy_term((Label,Univ,Free),(LabelB,UnivB,Free)),
        extend_inst(Univ,Inst,NewInst),
        make_forbid(Univ,Inst,AddForbid),
        append(AddForbid,Forbid,NewForbid),
        append(Sleep,[(UnivA:NewInst:LabelA:(A;B))-Univ],SleepA),
        append(Sleep,[(UnivB:NewInst:LabelB:(A;B))-Univ],SleepB),
        prove(A,Label,[],[],AllLits,AllLits,UnExp,SleepA,AllLab,NonGrd,
              (Univ+Free),NewForbid),
        prove(B,Label,[],[],AllLits,AllLits,UnExp,SleepB,AllLab,NonGrd,
              (Univ+Free),NewForbid).


% The box rule

prove(box Fml,Label,Univ,Inst,_,AllLits,UnExp,Sleep,AllLab,
      NonGrd,Free,Forbid) :- !,
	prove(Fml,[(X,_)|Label],[X|Univ],[[]|Inst],AllLits,AllLits,
              UnExp,Sleep,AllLab,NonGrd,Free,Forbid).


% The diamond rule

prove(dia Fml,Label,Univ,Inst,_,AllLits,UnExp,Sleep,AllLab,
      NonGrd,Free,Forbid) :- !,
	reverse([(Fml,Fml)|Label],TmpNewLabel),
        append(TmpNewLabel,_,NewLabel),
        prove(NonGrd,_,_,_,AllLits,AllLits,
              [(Univ:Inst:[(Fml,Fml)|Label]:Fml)|UnExp],
              Sleep,[NewLabel|AllLab],[],Free,Forbid).


% Check old closures

prove([(L1,L2,RevLabel)|RestNonG],_,_,_,_,AllLits,UnExp,Sleep,
      [NewLabel|AllLab],NonGrd,Free,Forbid) :- !,
	( L1 = L2,
          RevLabel = NewLabel,
          justified(RevLabel,AllLab),
	  check_forbid(Forbid),
          !
	; prove(RestNonG,_,_,_,AllLits,AllLits,UnExp,Sleep,[NewLabel|AllLab],
                NonGrd,Free,Forbid)
        ).


% Switch back to normal mode from mode for checking old closures
	
prove([],_,_,_,_,AllLits,[(Univ:Inst:Label:Fml)|UnExp],Sleep,AllLab,
      NonGrd,Free,Forbid) :- !,
        prove(Fml,Label,Univ,Inst,AllLits,AllLits,UnExp,Sleep,AllLab,
              NonGrd,Free,Forbid).


% Do not use the current literal for closure, continue expanding
% (only if list Lits is empty)

prove(Lit,LitLabel,_,_,[],AllLits,UnExp,Sleep,AllLab,NonGrd,Free,Forbid) :- !,
        ( (Lit = -Neg; -Lit = Neg) ->
          ( UnExp = [(Univ:Inst:Label:Fml)|UnExpR] ->
	    prove(Fml,Label,Univ,Inst,
                  [(LitLabel:Neg)|AllLits],[(LitLabel:Neg)|AllLits],
                  UnExpR,Sleep,AllLab,NonGrd,Free,Forbid)
          ; wake_up(Sleep,(Univ:Inst:Label:Fml),SleepR),
	    prove(Fml,Label,Univ,Inst,
                  [(LitLabel:Neg)|AllLits],[(LitLabel:Neg)|AllLits],
                  [],SleepR,AllLab,NonGrd,Free,Forbid)
          )
        ).


% Try to use the current literal for closure

prove(Lit1,Label1,_,_,[(Label2:Lit2)|Lits],AllLits,UnExp,Sleep,
      AllLab,NonGrd,Free,Forbid) :-
	( \+(Label1:Lit1 = Label2:Lit2) ->
 	  prove(Lit1,Label1,_,_,Lits,AllLits,UnExp,Sleep,AllLab,NonGrd,
                Free,Forbid)
        ; copy_term((Label1,Free),(NewLabel1,Free)),
          copy_term((Label2,Free),(NewLabel2,Free)),
          reverse(NewLabel1,RevLabel),
          ( NewLabel1 = NewLabel2,
            justified(RevLabel,AllLab),
            check_forbid(Forbid),
            !
          ; prove(Lit1,Label1,_,_,Lits,AllLits,UnExp,Sleep,AllLab,
                  [(NewLabel1,NewLabel2,RevLabel)|NonGrd],Free,Forbid)
          )
        ).
    


% ADDITIONAL PREDICATES

% wake_up(+Sleep,-Fml,-RestSleep)
%
% Looks for the first formula in Sleep than can be woken up. 
% It is returned in Fml, all other formulae in Slepp are returned in 
% the list RestSleep.

wake_up([(Fml-Vars)|Sleep],Fml,Sleep) :- 
	contains_ground(Vars),
	!.

wake_up([First|Sleep],Fml,[First|RestSleep]) :- 
	wake_up(Sleep,Fml,RestSleep).

contains_ground([H|_]) :- ground(H),!.
contains_ground([_|T]) :- contains_ground(T).


% justified(+Label,+AllLab)
%
% Checks whether Label is justified by the list AllLab of labels.

justified(Label,_) :- ground(Label).

justified(Label,[Label|T]) :- justified(Label,T).
	
justified(Label,[_|T]) :- justified(Label,T).


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
