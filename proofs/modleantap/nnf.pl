%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nnf.pl
% Sicstus Prolog
% Copyright (C) 1997: Bernhard Beckert (University of Karlsruhe) and 
%                     Rajeev Gore (Australian National University)
%                     Email: beckert@ira.uka.de, rajeev.gore@arp.anu.edu.au
%
% Purpose:            Transforming formulae into NNF.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- module(nnf,[nnf/3]).

:- op(400,fy,-), 
   op(500,xfy,&), 
   op(600,xfy,v),
   op(650,xfy,=>), 
   op(700,xfy,<=>),
   op(400,fy,box), 
   op(400,fy,dia).

% nnf(+Fml,-NNF,-Paths)
% 
% Transforms the propositional modal formula Fml into negation normal form
% which is returned in NNF. Paths is the number of disjunctive paths in the
% formula.
%
% In Fml the following logical operators may be used arbitrarily
% nested: - (negation), & (conjunction), v (disjunction),
% => (implication), <=> (equivalence), box (box operator),  dia (diamond
% operator), true, and false.
%
% In NNF only the operators `-' (negation), `,' (conjunction), 
% `;' (disjunction), box (box operator), and dia (diamond operator)
% are used, and `-' only occurs on the atomic level.
%
% In NNF, the parts of disjunctions are re-ordered; those parts which
% have less disjunctive paths are moved to the front.


nnf(Fml,NNF,Paths) :- 
	( Fml = true       -> Fml1 = (p v -p);
	  Fml = false      -> Fml1 = (p & -p);
 	  Fml = -true      -> Fml1 = (p & -p);
	  Fml = -false     -> Fml1 = (p v -p);
          Fml = -(-F)      -> Fml1 = F;
	  Fml = -(dia F)   -> Fml1 = box (-F);
	  Fml = -(box F)   -> Fml1 = dia (-F);
	  Fml = -(A v B)   -> Fml1 = (-A) & (-B);
	  Fml = -(A & B)   -> Fml1 = (-A) v (-B);
	  Fml = (A => B)   -> Fml1 = (-A) v B;
	  Fml = -(A => B)  -> Fml1 = A & (-B);
	  Fml = (A <=> B)  -> Fml1 = (A & B) v ((-A) & (-B));
	  Fml = -(A <=> B) -> Fml1 = (A & (-B)) v ((-A) & B)
        ),
	nnf(Fml1,NNF,Paths).


nnf(box F,box NNF,Paths) :- !,
	nnf(F,NNF,Paths).

nnf(dia F,dia NNF,Paths) :- !,
	nnf(F,NNF,Paths).

nnf(A & B,NNF,Paths) :- !,
	nnf(A,NNF1,Paths1),
	nnf(B,NNF2,Paths2),
	Paths is Paths1 * Paths2,
	( Paths1 > Paths2 -> 
          NNF = (NNF2,NNF1)
        ; NNF = (NNF1,NNF2)
        ).

nnf(A v B,NNF,Paths) :- !,
	nnf(A,NNF1,Paths1),
	nnf(B,NNF2,Paths2),
	Paths is Paths1 + Paths2,
	( Paths1 > Paths2 -> 
          NNF = (NNF2;NNF1)
        ; NNF = (NNF1;NNF2)
        ).

nnf(Lit,Lit,1).
