%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% modlean_k.pl
% Sicstus Prolog
% Copyright (C) 1997: Bernhard Beckert (University of Karlsruhe) and
%                     Rajeev Gore (Australian National University)
%                     Email: beckert@ira.uka.de, rajeev.gore@arp.anu.edu.au
%
% Purpose:            Tableau-based theorem prover for NNF formulae
%                     of the propositional modal logic K
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- module(modlean_k,[prove_k/3]).

:- op(400,fy,box),
   op(400,fy,dia).

:- use_module(library(lists),[reverse/2,append/3]).

%%%%%%%%%% BEGIN OF TOPLEVEL PREDICATES

% -----------------------------------------------------------------
% prove_k(+Fml,?Limit)
%
% Succeeds if there is a closed tableau for Fml with not more
% than Limit free variables on each branch.
%
% Fml is a formula of propositional modal logic, i.e., the
% logical operators `-' (negation), `,' (conjunction),
% `;' (disjunction), box (box operator), and dia (diamond operator)
% may be used, where `-' only occurs on the atomic level.
%
% Iterative deepening is used when Limit is unbound.

prove_k(Fml,Limit,P) :-
	nonvar(Limit),!,
	prove(e,Fml,[1],[],[],[],[],[],[],[],[],Limit,P).

prove_k(Fml,Result,P) :-
	iterate(Limit,1,prove(e,Fml,[1],[],[],[],[],[],[],[],[],Limit,P),Result).

iterate(Current,Current,Goal,Current) :-
	nl,
	write('Limit = '),
	write(Current),nl,
	Goal.

iterate(Limit,Current,Goal,Result) :-
	Current1 is Current + 1,
	iterate(Limit,Current1,Goal,Result).

%%%%%%%%%% END OF TOPLEVEL PREDICATES


% prove(Fml,Label,Univ,Lits,AllLits,UnExp,Sleep,AllLab,NonGrd,Free,Limit)
%
% Fml: If it is _not_ a Prolog list, it is the current formula. If it is
%      a Prolog list, it is a list of closures that could not be made ground
%      before, but should be checked again at this point. A closure is of the
%      form ((Label1:Lit1),(Label2,Neg2),Rev), where Neg2 is the negation of
%      the  second literal Lit2 and Rev is the label Label1 reversed.
% Label: The label of the current formula.
% Univ: The list of universal variables in the curren formula.
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
% Limit: An integer limiting the length of FreeV.
%
% In both Lits and AllLits, literals are stored in the form
% (Label:Negation), where Negation is the complement of the literal.
%
% In UnExp formulae are stored in the form (Univ:Label:Fml).
%
% In Sleep formulae are stored in the form (Univ:Label:Fml)-Vars, where
% Vars is a list that has to contain at least one ground atom, for the
% formula to be waken up.


% The conjunctive rule

prove(Ind,(A,B),Label,Univ,_,AllLits,UnExp,Sleep,AllLab,NonGrd,Free,Limit,P) :- !,
        copy_term((Label,Univ,Free),(LabelB,UnivB,Free)),
        prove([l:Ind],A,Label,Univ,AllLits,AllLits,[(UnivB:LabelB:B:[r:Ind])|UnExp],
              Sleep,AllLab,NonGrd,Free,Limit,P).


% The disjunctive rule

prove(Ind,(A;B),Label,Univ,_,AllLits,UnExp,Sleep,AllLab,NonGrd,Free,Limit,(P,Q)) :- !,
        Limit >= 0,
	copy_term((Label,Univ,Free),(LabelA,UnivA,Free)),
        copy_term((Label,Univ,Free),(LabelB,UnivB,Free)),
        append(Sleep,[(UnivA:LabelA:(A;B):Ind)-Univ],SleepA),
        append(Sleep,[(UnivB:LabelB:(A;B):Ind)-Univ],SleepB),
        length(Univ,Length),
	NewLimit is Limit - Length,
        prove([l:Ind], A,Label,[],AllLits,AllLits,UnExp,SleepA,AllLab,NonGrd,
              (Univ+Free),NewLimit,(P1,Q1)),
        prove([r:Ind], B,Label,[],AllLits,AllLits,UnExp,SleepB,AllLab,NonGrd,
              (Univ+Free),NewLimit,(P2,Q2)),
  append(P1,P2,P),
  append(Q1,Q2,Q).


% The box rule

prove(Ind, box Fml,Label,Univ,_,AllLits,UnExp,Sleep,AllLab,NonGrd,Free,Limit,P) :- !,
	prove([b(Ind,Y)],Fml,[((X,Y),_)|Label],[X|Univ],AllLits,AllLits,UnExp,Sleep,
              AllLab,NonGrd,Free,Limit,P).


% The diamond rule

prove(Ind,dia Fml,Label,Univ,_,AllLits,UnExp,Sleep,AllLab,NonGrd,Free,Limit,P) :- !,
	reverse([((Fml,Ind),(Fml,_))|Label],TmpNewLabel),
        append(TmpNewLabel,_,NewLabel),
        prove([l:Ind],NonGrd,_,_,AllLits,AllLits,[(Univ:[((Fml,Ind),(Fml,_))|Label]:Fml:[l:Ind])|UnExp],
              Sleep,[NewLabel|AllLab],[],Free,Limit,P).


% Check old closures

prove(_,[(L1,L2,RevLabel)|RestNonG],_,_,_,AllLits,UnExp,Sleep,
      [NewLabel|AllLab],NonGrd,Free,Limit,P) :- !,
	( L1 = L2,
          RevLabel = NewLabel,
          justified(RevLabel,AllLab)
	; prove(_,RestNonG,_,_,AllLits,AllLits,UnExp,Sleep,[NewLabel|AllLab],
                NonGrd,Free,Limit,P)
        ).

% Switch back to normal mode from mode for checking old closures

prove(_,[],_,_,_,AllLits,[(Univ:Label:Fml:Ind)|UnExp],Sleep,AllLab,
      NonGrd,Free,Limit,P) :- !,
        prove(Ind,Fml,Label,Univ,AllLits,AllLits,UnExp,Sleep,AllLab,
              NonGrd,Free,Limit,P).


% Do not use the current literal for closure, continue expanding
% (only if list Lits is empty)

prove(Ind1,Lit,LitLabel,_,[],AllLits,UnExp,Sleep,AllLab,NonGrd,Free,Limit,P) :- !,
        ( (Lit = -Neg; -Lit = Neg) ->
          ( UnExp = [(Univ:Label:Fml:Ind)|UnExpR] ->
	    prove(Ind,Fml,Label,Univ,
                  [(LitLabel:Neg:Ind1)|AllLits],[(LitLabel:Neg:Ind1)|AllLits],
                  UnExpR,Sleep,AllLab,NonGrd,Free,Limit,P)
          ; wake_up(Sleep,(Univ:Label:Fml:Ind),SleepR),
	    prove(Ind,Fml,Label,Univ,
                  [(LitLabel:Neg:Ind1)|AllLits],[(LitLabel:Neg:Ind1)|AllLits],
                  [],SleepR,AllLab,NonGrd,Free,Limit,P)
          )
        ).


% Try to use the current literal for closure

prove(Ind,Lit1,Label1,_,[(Label2:Lit2:Ind2)|Lits],AllLits,UnExp,Sleep,
      AllLab,NonGrd,Free,Limit,(P,Q)) :-
  term_string(Label1:Lit1,S1),term_string(Label2:Lit2,S2),print(S1),nl,print(S2),nl,
	( \+(Label1:Lit1 = Label2:Lit2) ->
    print("no"),nl,
 	  prove(Ind,Lit1,Label1,_,Lits,AllLits,UnExp,Sleep,AllLab,NonGrd,
                Free,Limit,(P,Q))
        ; copy_term((Label1,Free),(NewLabel1,Free)),
          copy_term((Label2,Free),(NewLabel2,Free)),
          print("oui"),nl,
          reverse(NewLabel1,RevLabel),
          term_string(NewLabel1,SS1),term_string(NewLabel2,SS2),print(SS1),nl,print(SS2),nl,
          ( NewLabel1 = NewLabel2,
            justified(RevLabel,AllLab),
          print("oui2"),nl,
            Q = [],
            P = [(Ind,Ind2)]
          ; prove(Ind,Lit1,Label1,_,Lits,AllLits,UnExp,Sleep,AllLab,
                  [(NewLabel1,NewLabel2,RevLabel)|NonGrd],Free,Limit,(P,Q))
          )
        ).


% wake_up(+Sleep,-Fml,-RestSleep)
%
% Looks for the first formula in Sleep than can be woken up.
% It is returned in Fml, all other formulae in Slepp are returned in
% the list RestSleep.
%
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

justified(Label,_) :- isGround(Label).

justified(Label,[Label|T]) :- justified(Label,T).

justified(Label,[_|T]) :- justified(Label,T).

isGround([]).
isGround([((H,_),_)|R]) :-
  ground(H),
  isGround(R).



