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

prove_k(Fml,Limit,Proof) :-
	nonvar(Limit),!,
	prove(Fml,eind,[((1,empty),(1,empty))],[],[],[],[],[],[],[],[],Limit,Proof).

prove_k(Fml,Result) :-
	iterate(Limit,1,prove(Fml,[],[((1,empty),(1,empty))],[],[],[],[],[],[],[],[],Limit),Result).

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

% The proof certificate object is a tuple ([Lbl:Ind1:Ind2|P],[Ind6:Ind3|L])
% where P contains an element for every closure which contains the label Lbl = ((L:Ind),_) of the two literals
% L is the label of the two literals
% Ind is the index of the diamond which introduced this label (world)
% Ind1 is the index of the first literal
% Ind2 is the index of the second literal
% Ind6 is the index of a box matching an Ind3 of a diamond. The second list L should cover all diamonds occurring in P

% The conjunctive rule

prove((A,B),Ind,Label,Univ,_,AllLits,UnExp,Sleep,AllLab,NonGrd,Free,Limit,dectree(Ind,none,[P])) :- !,
        copy_term((Label,Univ,Free),(LabelB,UnivB,Free)),
        prove(A,lind(Ind),Label,Univ,AllLits,AllLits,[(UnivB:LabelB:B:rind(Ind))|UnExp],
              Sleep,AllLab,NonGrd,Free,Limit,P).


% The disjunctive rule

prove((A;B),Ind,Label,Univ,_,AllLits,UnExp,Sleep,AllLab,NonGrd,Free,Limit,dectree(Ind,none,[P1,P2])) :- !,
        Limit >= 0,
        %copy_term((Label,Univ,Free,Ind),(LabelA,UnivA,Free,IndA)),
        %copy_term((Label,Univ,Free,Ind),(LabelB,UnivB,Free,IndB)),
        %append(Sleep,[(UnivA:LabelA:(A;B):IndA)-Univ],SleepA),
        %append(Sleep,[(UnivB:LabelB:(A;B):IndB)-Univ],SleepB),
        length(Univ,Length),
	NewLimit is Limit - Length,
        prove(A,lind(Ind),Label,[],AllLits,AllLits,UnExp,Sleep,AllLab,NonGrd,
              (Univ+Free),NewLimit,P1),
        prove(B,rind(Ind),Label,[],AllLits,AllLits,UnExp,Sleep,AllLab,NonGrd,
              (Univ+Free),NewLimit,P2).


% The box rule

prove(box Fml,Ind,Label,Univ,_,AllLits,UnExp,Sleep,AllLab,NonGrd,Free,Limit,dectree(Ind,Y,[P])) :- !,
	prove(Fml,bind(Ind,Y),[(X,Y)|Label],[X|Univ],AllLits,AllLits,UnExp,Sleep,
              AllLab,NonGrd,Free,Limit,P).


% The diamond rule

prove(dia Fml,Ind,Label,Univ,_,AllLits,UnExp,Sleep,AllLab,NonGrd,Free,Limit,dectree(Ind,none,[P])) :- !,
	reverse([(Fml,Ind)|Label],TmpNewLabel),
        append(TmpNewLabel,_,NewLabel),
        prove(NonGrd,_,_,_,AllLits,AllLits,[(Univ:[(Fml,Ind)|Label]:Fml:lind(Ind))|UnExp],
              Sleep,[NewLabel|AllLab],[],Free,Limit,P).


% Check old closures

prove([(L1,L2,RevLabel)|RestNonG],_,_,_,_,AllLits,UnExp,Sleep,
      [NewLabel|AllLab],NonGrd,Free,Limit,P) :- !,
	( L1 = L2,
          RevLabel = NewLabel,
          justified(RevLabel,AllLab)
	; prove(RestNonG,_,_,_,AllLits,AllLits,UnExp,Sleep,[NewLabel|AllLab],
                NonGrd,Free,Limit,P)
        ).

% Switch back to normal mode from mode for checking old closures

prove([],_,_,_,_,AllLits,[(Univ:Label:Fml:Ind)|UnExp],Sleep,AllLab,
      NonGrd,Free,Limit,P) :- !,
        prove(Fml,Ind,Label,Univ,AllLits,AllLits,UnExp,Sleep,AllLab,
              NonGrd,Free,Limit,P).


% Do not use the current literal for closure, continue expanding
% (only if list Lits is empty)

prove(Lit,Ind1,LitLabel,_,[],AllLits,UnExp,Sleep,AllLab,NonGrd,Free,Limit,P) :- !,
      ( (Lit = -Neg; -Lit = Neg) ->
          ( UnExp = [(Univ:Label:Fml:Ind)|UnExpR] ->
	    prove(Fml,Ind,Label,Univ,
                  [(LitLabel:Neg:Ind1)|AllLits],[(LitLabel:Neg:Ind1)|AllLits],
                  UnExpR,Sleep,AllLab,NonGrd,Free,Limit,P)
          ; wake_up(Sleep,(Univ:Label:Fml:Ind),SleepR),
	    prove(Fml,Ind,Label,Univ,
                  [(LitLabel:Neg:Ind1)|AllLits],[(LitLabel:Neg:Ind1)|AllLits],
                  [],SleepR,AllLab,NonGrd,Free,Limit,P)
          )
        ).


% Try to use the current literal for closure

prove(Lit1,Ind,Label1,_,[(Label2:Lit2:Ind2)|Lits],AllLits,UnExp,Sleep,
      AllLab,NonGrd,Free,Limit,P) :-
        %term_string(Label1,LL1), term_string(Label2,LL2), term_string(Lit1,LL3), term_string(Lit2,LL4), print("LL1 --> "),print(LL1),nl, print("LL3 --> "),print(LL3),nl, print("LL2 --> "),print(LL2),nl, print("LL4 --> "),print(LL4),nl, nl,
        Lit1 = Lit2 ->
        %term_string(Label1,S1), term_string(Label2,S2), print(" >>11>>>  "),print(S1), print(" - "),print(S2), print(" -----  "),
        Label1 = Label2
        %term_string(Label1,S3), term_string(Label2,S4), print(" >>22>>>  "),print(S3), print(" - "),print(S4), print(" -----  ")
        ->  P = dectree(Ind,Ind2,[]);
	(
    ((Label1 = Label2), prove(Lit1,Ind,Label1,_,Lits,AllLits,UnExp,Sleep,AllLab,NonGrd,
                Free,Limit,P)) % here we try the next paper but since we copy labels, we must try to unify them here so we get a concrete value for Y instead of _xxx
        ; prove(Lit1,Ind,Label1,_,Lits,AllLits,UnExp,Sleep,AllLab,NonGrd,
                Free,Limit,P) % if the two do not unify (can it only be because Y is instantiated into two different values?) then try the next label without unifying them.
        ; copy_term((Label1,Free),(NewLabel1,Free)),
          copy_term((Label2,Free),(NewLabel2,Free)),
          %term_string(Label1,LLL1), term_string(Label2,LLL2), term_string(RevLabel,LLL3), term_string(AllLab,LLL4), print("LLL1 --> "),print(LLL1),nl,  print("LLL3 --> "),print(LLL3),nl, print("LLL2 --> "),print(LLL2),nl, print("LLL4 --> "),print(LLL4),nl, nl,

          reverse(NewLabel1,RevLabel),
          ( NewLabel1 = NewLabel2,
            justified(RevLabel,AllLab)
            % we have to update K for the justified here as well but first check if the proof info as of now is incomplete
            % try to use the certificate in order to build a proof on whiteboard.
          ; prove(Lit1,Ind,Label1,_,Lits,AllLits,UnExp,Sleep,AllLab,
                  [(NewLabel1,NewLabel2,RevLabel)|NonGrd],Free,Limit,P)
          )
      ).

unify([],[]).
unify([X|L1],[Y|L2]) :- var(X),  X = [Y|_], unify(L1,L2).
unify([X|L1],[Y|L2]) :- var(Y),  Y = [X|_], unify(L1,L2).
unify([[X|_]|L1],[Y|L2]) :- var(X),  X = Y, unify(L1,L2).
unify([X|L1],[[Y|_]|L2]) :- var(Y),  X = Y, unify(L1,L2).
unify([[_|L]|L1],[Y|L2]) :-  unify([L|L1],[Y|L2]).
unify([X|L1],[[_|L]|L2]) :-  unify([X|L1],[L|L2]).
unify([(F,X)|L1],[(G,Y)|L2]) :- !, F = G, unify([X|L1],[Y|L2]).
unify([X|L1],[Y|L2]) :- X = Y, unify(L1,L2).

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

isGround([]).
isGround([((H,_),_)|R]) :-
  ground(H),
  isGround(R).

justified(Label,_) :-
  isGround(Label).

justified(Label,[Label|T]) :-
  justified(Label,T).

justified(Label,[_|T]) :-
  justified(Label,T).


