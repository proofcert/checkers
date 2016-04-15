%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% modlean_kd.pl
% Sicstus Prolog
% Copyright (C) 1997: Bernhard Beckert (University of Karlsruhe) and 
%                     Rajeev Gore (Australian National University)
%                     Email: beckert@ira.uka.de, rajeev.gore@arp.anu.edu.au
%
% Purpose:            Tableau-based theorem prover for NNF formulae
%                     of the propositional modal logic KD
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- module(modlean_kd,[prove_kd/2]).

:- op(400,fy,box), 
   op(400,fy,dia).

:- use_module(library(lists),[reverse/2,append/3]).

%%%%%%%%%% BEGIN OF TOPLEVEL PREDICATES
	
% -----------------------------------------------------------------
% prove_kd(+Fml,?Limit)
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

prove_kd(Fml,Limit) :-
	nonvar(Limit),!,
	prove(Fml,[1],[],[],[],[],[],Limit).

prove_kd(Fml,Result) :-
	iterate(Limit,1,prove(Fml,[1],[],[],[],[],[],Limit),Result).

iterate(Current,Current,Goal,Current) :- nl,
	write('Limit = '),
	write(Current),nl,
	Goal.

iterate(Limit,Current,Goal,Result) :-
	Current1 is Current + 1,
	iterate(Limit,Current1,Goal,Result).

%%%%%%%%%% END OF TOPLEVEL PREDICATES


% prove(Fml,Label,Univ,Lits,UnExp,Sleep,Free,Limit)
%
% Fml: The current formula.
% Label: The label of the current formula
% Univ: The list of universal variables in the curren formula
% Lits: The set of literals that have not been used yet to be unified
%       with the current formula to close the current branch
% UnExp: The set of formulae that have not been considered yet
% Sleep: Formulae that have been put asleep
% Free: A list of the variables introduced in labels (can be instantiated)
% Limit: An integer limiting the number of free variables on a branch
%
% In Lits literals are stored in the form
% (Label:Negation), where Negation is the complement of the literal
%
% In UnExp formulae are stored in the form (Univ:Label:Fml)
%
% In Sleep formulae are stored in the form (Univ:Label:Fml)-Vars, where
% Vars is a list that has to contain at least one ground atom, for the 
% formula to be waken up.


% The conjunctive rule

prove((A,B),Label,Univ,Lits,UnExp,Sleep,Free,Limit) :- !,
        copy_term((Label,Univ,Free),(LabelB,UnivB,Free)),
        prove(A,Label,Univ,Lits,[(UnivB:LabelB:B)|UnExp],Sleep,Free,Limit).


% The disjunctive rule

prove((A;B),Label,Univ,Lits,UnExp,Sleep,Free,Limit) :- !,
	Limit >= 0,
        copy_term((Label,Univ,Free),(LabelA,UnivA,Free)),
        copy_term((Label,Univ,Free),(LabelB,UnivB,Free)),
        append(Sleep,[(UnivA:LabelA:(A;B))-Univ],SleepA),
        append(Sleep,[(UnivB:LabelB:(A;B))-Univ],SleepB),
        length(Univ,Length),
	NewLimit is Limit - Length,
        prove(A,Label,[],Lits,UnExp,SleepA,(Univ+Free),NewLimit),
        prove(B,Label,[],Lits,UnExp,SleepB,(Univ+Free),NewLimit).


% The box rule

prove(box Fml,Label,Univ,Lits,UnExp,Sleep,Free,Limit) :- !,
        prove(Fml,[X|Label],[X|Univ],Lits,UnExp,Sleep,Free,Limit).


% The diamond rule

prove(dia Fml,Label,Univ,Lits,UnExp,Sleep,Free,Limit) :- !,
        prove(Fml,[Fml|Label],Univ,Lits,UnExp,Sleep,Free,Limit).


% Try to use the current literal for closure

prove(Lit,Label,_,[L|Lits],_,_,Free,_) :-
        copy_term(((Label:Lit),Free),(New,Free)),
        (    copy_term((L,Free),(New,Free))
        ;    prove(Lit,Label,_,Lits,[],[],_,_)
        ).


% Do not use the current literal for closure, continue expanding

prove(Lit,LitLabel,_,Lits,UnExp,Sleep,Free,Limit) :- !,
        ( (Lit = -Neg; -Lit = Neg) ->
          ( UnExp = [(Univ:Label:Fml)|UnExpR] ->
	    prove(Fml,Label,Univ,[(LitLabel:Neg)|Lits],UnExpR,Sleep,Free,Limit)
          ; wake_up(Sleep,(Univ:Label:Fml),SleepR),
	    prove(Fml,Label,Univ,[(LitLabel:Neg)|Lits],[],SleepR,Free,Limit)
          )
        ).


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

