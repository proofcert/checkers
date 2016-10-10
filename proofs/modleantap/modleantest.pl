%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% modleantest.pl
% Sicstus Prolog
% Copyright (C) 1998: Bernhard Beckert (University of Karlsruhe) and
%                     Rajeev Gore (Australian National University)
%                     Email: beckert@ira.uka.de, rajeev.gore@arp.anu.edu.au
%
% Purpose:            Shell and test data for ModLeanTAP
%                     Provides an interface to both Version 1 and Version 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(400,fy,-),
   op(500,xfy,&),
   op(600,xfy,v),
   op(650,xfy,=>),
   op(700,xfy,<=>),
   op(400,fy,box),
   op(400,fy,dia).

:-	use_module(modlean_kt,[prove_kt/2]).
:-	use_module(modlean_k,[prove_k/2]).
:-	use_module(modlean_s4,[prove_s4/2]).
:-	use_module(modlean_kd,[prove_kd/2]).

:-	use_module(modlean_dec_kt,[decprove_kt/1]).
:-	use_module(modlean_dec_k,[decprove_k/1]).
:-	use_module(modlean_dec_s4,[decprove_s4/1]).
:-	use_module(modlean_dec_kd,[decprove_kd/1]).

:-	use_module(nnf,[nnf/3]).

:-	use_module(library(lists),[member/2]).

% ------------------------------------------------------------
%
% provefml(+Name)
% incprovefml(+Name)
% decprovefml(+Name)
%
% provefml succeeds if there is a fact fml(Name,Limit,Formula,Logic) in
% the data base.
% Formula is transformed into negation normal form, and the  appropriate
% version of ModLeanTAP is used to show is to be unsatisfiable using the
% limit Limit.
% Some statistics are printed.
%
% incprovefml is the same as provefml, but incrementally increases the
% limit instead of using Limit.
%
% decprovefml is similar but uses Version 2.0 of ModLeanTAP, i.e., a
% decision procedure.
% It succeeds if there is a fact fml(Name,Limit,Formula,Logic) in
% the data base.
% Limit is ignored as the decision procedure does not use any limit.

provefml(Name,P) :-
	fml(Name,Limit,Formula,Logic),
	write(Name),
	nnf(Formula,NNF,_),
  print(NNF),
	statistics(runtime,[_,_]),
        ( Logic == kt -> ( prove_kt(NNF,Limit) -> Proof = yes ; Proof = no)
        ; Logic == k  -> ( prove_k(NNF,Limit,P)  -> Proof = yes ; Proof = no)
        ; Logic == kd -> ( prove_kd(NNF,Limit) -> Proof = yes ; Proof = no)
        ; Logic == s4 -> ( prove_s4(NNF,Limit) -> Proof = yes ; Proof = no)
        ; write('No such logic.'), fail
        ),
	!,
        ( Proof = yes ->
          statistics(runtime,[_,Time]),
	  format(' proved in ~w msec, VarLim = ~w ~n',[Time,Limit])
        ; statistics(runtime,[_,Time]),
          format(' no proof after ~w msec. ~n',[Time])
        ).

incprovefml(Name) :-
	fml(Name,_,Formula,Logic),
	write(Name),
	nnf(Formula,NNF,_),
	statistics(runtime,[_,_]),
        ( Logic == kt -> ( prove_kt(NNF,Limit) -> Proof = yes ; Proof = no)
        ; Logic == k  -> ( prove_k(NNF,Limit)  -> Proof = yes ; Proof = no)
        ; Logic == kd -> ( prove_kd(NNF,Limit) -> Proof = yes ; Proof = no)
        ; Logic == s4 -> ( prove_s4(NNF,Limit) -> Proof = yes ; Proof = no)
        ; write('No such logic.'), fail
        ),
        !,
	( Proof = yes ->
          statistics(runtime,[_,Time]),
	  format(' proved in ~w msec, VarLim = ~w ~n',[Time,Limit])
        ; statistics(runtime,[_,Time]),
          format(' no proof after ~w msec. ~n',[Time])
        ).

decprovefml(Name) :-
	fml(Name,_,Formula,Logic),
	write(Name),
	nnf(Formula,NNF,_),
	statistics(runtime,[_,_]),
        ( Logic == kt -> ( decprove_kt(NNF) -> Proof = yes ; Proof = no)
        ; Logic == k  -> ( decprove_k(NNF)  -> Proof = yes ; Proof = no)
        ; Logic == kd -> ( decprove_kd(NNF) -> Proof = yes ; Proof = no)
        ; Logic == s4 -> ( decprove_s4(NNF) -> Proof = yes ; Proof = no)
        ; write('No such logic.'), fail
        ),
        !,
	( Proof = yes ->
          statistics(runtime,[_,Time]),
	  format(' proved to be UNSATISFIABLE in ~w msec. ~n',[Time])
        ; statistics(runtime,[_,Time]),
          format(' shown to be SATISFIABLE in ~w msec. ~n',[Time])
        ).


% fml(+Name,-Limit,-Formula,Logic)
% fml(+Name,-Limit,-Formula)
%
% fml is used to specify a test problem: the formula Formula with name Name
% is to be proven to be *unsatisfiable* using the version of ModLeanTAP for
% the logic Logic.
%
% The logical operators  - (negation), & (conjunction), v (disjunction),
% => (implication), <=> (equivalence), box (box operator),
% dia (diamond operator), true, and false may be used.
%
% If no logic is specified (i.e., fml/3 is used), then the logic K is
% used by default.

fml(Name,Limit,Formula,k) :- fml(Name,Limit,Formula).

fml(branch,2,-(-(p100 & -p101 & ((p101 => p100) & (p102 => p101) & ((p100 => (p0 => box (p100 => p0)) & (-p0 => box (p100 => -p0))) & (p101 => (p1 => box (p101 => p1)) & (-p1 => box (p101 => -p1)))) & (p100 & -p101 => dia (p101 & -p102 & p1) & dia (p101 & -p102 & -p1)) & box ((p101 => p100) & (p102 => p101) & ((p100 => (p0 => box (p100 => p0)) & (-p0 => box (p100 => -p0))) & (p101 => (p1 => box (p101 => p1)) & (-p1 => box (p101 => -p1)))) & (p100 & -p101 => dia (p101 & -p102 & p1) & dia (p101 & -p102 & -p1))))) v -box p1),k).

fml(m0,2,((box (p;q)) & (dia ((-p) & (-q)))),k).
fml(m1,2,((box (p & q)) & ((dia (-p)) ; (dia (-q)))),k).

fml(x1,2,((dia -p v dia -q) & box (p & q)),k).

fml(t1,2,-((box(p => q)) => ((box p) => (box q))),k).

fml(t2,2,-(((box(p & q))) => ((box p) & (box q))),k).

fml(t3,2,-(((box p) & (box (p => q))) => (box q)),k).

fml(t4,2,-((((box p) & (dia (-q))) => (dia (p & (-q))))),k).

fml(t5,2,-((((dia p) v (dia q)) => (dia(p v q)))),k).

fml(t6,2,(-(((box(p => q)) => ((box p) => (box q))) &
           (((box(p & q))) => ((box p) & (box q))) &
           (((box p) & (box (p => q))) => (box q)) &
           ((((box p) & (dia (-q))) => (dia (p & (-q))))) &
           ((((dia p) v (dia q)) => (dia(p v q)))))),k).



fml(tst1,10,-(box p => p), kt).

fml(tst2,10,-(p => dia p), kt).

fml(tst3,10,-(dia dia p => dia p), kt4).

fml(tst4,10,-(box p => box box p), kt4).

fml(tst5,10,-(box p => dia p), kd).

fml(tst6,10,-(box p => dia p), kd45).

fml(tst8,23,-(box (box (p => box p) => p) => (box (p => box p) => p)),s4).

fml(tst9,10,-((box box p) => box p), s4).

fml(tst10,20,-((box box (p => box p)) => box (p => box p)), s4).

fml(tst11,50,-((dia dia p & box dia q & dia q) => dia p), s4).


fml(kt1,10, -(box p => p), kt).

fml(kt2,10, -(p => dia p), kt).

fml(k45a,10,-(dia box p => box p),k45).

fml(k5a,10,-(dia box p => box p), k5).

fml(k5b,10,-(box (box p => box box p)), k5).

fml(kb1,10,-(dia box p => p), kb).

fml(ktb1,10,-(box p => p), ktb).

fml(s5a,10,-(dia box p => p), s5).

fml(s5b,10,-(dia box p => box p), s5).

fml(s5c,10,-(box dia p => dia p), s5).

fml(s4a,10,-(box dia (p => box dia p)), s4).

fml(s4b,10,-(box dia (dia box p => p)), s4).

fml(s4c,10,-((box box (p => box p)) => box (p => box p)), s4).

fml(kt3,20, -(box (p => q) & box ((p => q) => box (p => q)) &
              box (box (p => q) => p) => q), kt).

fml(bt,2,((dia (-q & -p) & dia (r & -p)) & box (p v q)),kd).

fml(raj6c,2, ((box (-(p) v dia-(p))) & (box (p v q) & box (box p v q))
               & dia -(p) & dia(-q))).

fml(raj6c11, 4, ((box (-(p) v dia-(p))) & (box (p v q) & box (box p v
                   q) & box (p v box q)) & dia -(q))).

fml(raj6c1, 4, ((box (-(p) v dia-(p))) & (box (p v q & r) & box (box p
                v q) & box (p v box q)) & dia -(p) & dia -(q))).

fml(raj6e1a1, 3, ((box (q v -(p))) & (box (p) & box (box q) & box (box
                    q)) & dia -(p) & dia -(q))).

fml(raj6e1a2, 3, ((box (q v -(p))) & (box (p) & box (box q) & box (p))
                    & dia -(p) & dia -(q))).

fml(raj6e1b, 3, ((box (q v -(p))) & (box (p) & box (box p) & box (p v
                    box q)) & dia -(p) & dia -(q))).

fml(lwb1, 1, -(box p1 v box p2 v box p3 v box p5 v false v (dia -p2 v
               dia -p4 v dia -p2 v dia -p6))).

fml(lwb2, 13, -(box p1 v box p2 v box p3 v box p5 v (dia (-p1 & box
                p1) v dia (-p1 & box p3) v dia (-p2 & box p5) v (dia
                (-p3 & box p1) v dia (-p3 & box p3)) v (dia (-p5 & box
                p1) v dia (-p5 & box p3)) v (dia (-p4 & box p2) v dia
                (-p6 & box p2)) v (dia (-p4 & box p4) v dia (-p6 & box
                p4)) v (dia (-p4 & box p6) v dia (-p6 & box p6))) v
                (dia dia -p2 v dia dia -p4 v dia dia -p5 v dia dia
                -p6))).

fml(lwb3, 53, -(box p1 v box p2 v box p3 v box p5 v (dia (-p1 & box
                p1) v dia (-p1 & box p3) v dia (-p2 & box p5) v (dia
                (-p3 & box p1) v dia (-p3 & box p3)) v (dia (-p5 & box
                p1) v dia (-p5 & box p3)) v (dia dia (-p1 & box p1) v
                dia dia (-p1 & box p3) v dia dia (-p1 & box p5)) v
                (dia (-p4 & box p2) v dia (-p6 & box p2)) v (dia dia
                (-p3 & box p1) v dia dia (-p3 & box p3) v dia dia (-p3
                & box p5)) v (dia (-p4 & box p4) v dia (-p6 & box p4))
                v (dia dia (-p5 & box p1) v dia dia (-p5 & box p3) v
                dia dia (-p5 & box p2) v dia dia (-p5 & box p5)) v
                (dia (-p4 & box p6) v dia (-p6 & box p6)) v (dia dia
                (-p2 & box p2) v dia dia (-p4 & box p2) v dia dia (-p6
                & box p2)) v (dia dia (-p2 & box p4) v dia dia (-p4 &
                box p4) v dia dia (-p6 & box p4)) v (dia dia (-p2 &
                box p6) v dia dia (-p4 & box p6) v dia dia (-p6 & box
                p6))) v (dia dia dia -p2 v dia dia dia -p4 v dia dia
                dia -p2 v dia dia dia -p6))).

fml(lwb4, 40, -(box p1 v box p2 v box p3 v box p5 v (dia (-p1 & box
                p3) v dia (-p1 & box p5) v dia (-p2 & box p1) v (dia
                (-p3 & box p3) v dia (-p3 & box p5)) v (dia (-p5 & box
                p3) v dia (-p5 & box p5)) v (dia dia (-p1 & box p1) v
                dia dia (-p1 & box p3) v dia dia (-p1 & box p4) v dia
                dia (-p1 & box p5)) v (dia (-p4 & box p2) v dia (-p6 &
                box p2)) v (dia dia (-p3 & box p1) v dia dia (-p3 &
                box p3) v dia dia (-p3 & box p5)) v (dia (-p4 & box
                p4) v dia (-p6 & box p4)) v (dia dia (-p5 & box p1) v
                dia dia (-p5 & box p3) v dia dia (-p5 & box p5)) v
                (dia (-p4 & box p6) v dia (-p6 & box p6)) v (dia dia
                dia (-p1 & box p3) v dia dia dia (-p1 & box p5)) v
                (dia dia (-p2 & box p2) v dia dia (-p4 & box p2) v dia
                dia (-p6 & box p2)) v (dia dia dia (-p3 & box p3) v
                dia dia dia (-p3 & box p5)) v (dia dia dia (-p4 & box
                p1) v (dia dia (-p2 & box p4) v dia dia (-p4 & box p4)
                v dia dia (-p6 & box p4))) v (dia dia dia (-p5 & box
                p3) v dia dia dia (-p5 & box p5)) v (dia dia (-p2 &
                box p6) v dia dia (-p4 & box p6) v dia dia (-p6 & box
                p6)) v (dia dia dia (-p2 & box p2) v dia dia dia (-p6
                & box p2)) v (dia dia dia (-p2 & box p4) v dia dia dia
                (-p6 & box p4)) v (dia dia dia (-p2 & box p6) v dia
                dia dia (-p6 & box p6))) v (dia dia dia dia -p2 v dia
                dia dia dia -p4 v dia dia dia dia -p1 v dia dia dia
                dia -p6))).


fml(tx1,10,-((box p => dia p) => dia true)).

fml(tx2,10,-((dia true => box p => dia p))).

fml(tx3,10,-((box p => box box p) => box p & dia q => dia (box p & q))).

fml(tx4,10,-((box p & dia -box p => dia (box p & -box p)) => box p =>
              box box p)).

fml(tx5,10,-((dia p => box dia p) => dia p & dia q => dia (dia p & q))).

fml(tx6,10,-((dia p & dia -dia p => dia (dia p & -dia p)) => dia p =>
              box dia p)).

fml(tx7,10,-((p => box dia p) => p & dia q => dia (dia p & q))).

fml(tx8,10,-((p & dia -dia p => dia (dia p & -dia p)) => p => box dia p)).

fml(tx9,10,-((box false => false) => box p => dia p)).

fml(tx10,10,-((box dia -p => dia -p) & (dia box p => box dia box p) &
               box (dia -p => box dia -p) => box p => box box p)).

fml(tx11,10,-((box -p => -p) & (dia p => box dia p) => p => box dia p)).

fml(tx12,10,-((box (box -p => box box -p) & (dia p => box dia dia p)
               => dia p => box dia p))).

fml(tx13,10,-((box (dia -p => box dia -p) & (box p => box dia box p)
               => box p => box box p))).

fml(tx14,10,-((box p => dia p) & (box p => box box p) & (-p => box dia
               -p) => box p => p)).

fml(tx15,10,-((dia box q => box dia q) => dia (p & box q) => box (p v
               dia q))).

fml(tx16,10,-((box (box p => dia p) & (dia (box p & box p) => box (box
               p v dia p)) => dia box p => box dia p))).

fml(tx17,3,-((box (p & box p => q) v box (q & box q => p) => box (p v
               q) & box (box p v q) & box (p v box q) => box p v box q))).

fml(tx18,10,-((box ((p & box p => q) v (q & box q => p)) & box (box (p
               & box p => q) v (q & box q => p)) & box ((p & box p =>
               q) v box (q & box q => p)) => box (p & box p => q) v
               box (q & box q => p)) => box (p & box p => q) v box (q
               & box q => p))).

fml(tx19,10,-((box (box p => q) v box (box q => p) => box (box p v q)
               & box (p v box q) => box p v box q))).

fml(tx20,10,-((box (box (box p => q) v (box q => p)) & box ((box p =>
               q) v box (box q => p)) => box (box p => q) v box (box q
               => p)) => box (box p => q) v box (box q => p))).

fml(tx21,10,-((box (box p => q) v box (box q => p) => box (p & box p
               => q) v box (q & box q => p)))).

fml(tx22,10,-((box (box p => p) & box (box q => q) & (box (p & box p
               => q) v box (q & box q => p)) => box (box p => q) v box
               (box q => p)))).

fml(tx23,10,-((box (box p => p) & box (box q => q) & (box (box p =>
               box q) v box (box q => box p)) => box (box p => q) v
               box (box q => p)))).

fml(tx24,10,-((box (p & box p => q) => box box (p & box p => q)) &
               (box (q & box q => p) => box box (q & box q => p)) &
               box (box p => box box p) & box (box q => box box q) &
               (box (p & box p => q) v box (q & box q => p)) => box
               (box p => box q) v box (box q => box p))).

fml(tx25,10,-((dia box p => box dia box p) & box (dia -p => box dia
               -p) => box (box p => box q) v box (box q => box p))).

fml(tx26,10,-((box (box -p => dia -p) & (box (box p => box -p) v box
               (box -p => box p)) => dia box p => box dia p))).

fml(tx27,5,-((dia p => box dia p) & (dia -p => box dia -p) => dia box
               p => box dia p)).

fml(tx28,10,-((box (box dia p => dia box p) => box dia p => dia box p)
               & box (box p => box box p) & box (box dia p => dia box
               p) => dia box (p => box p))).

fml(tx29,10,-((box dia box (p => box p) => dia box (p => box p)) &
               (box dia -p => box box dia -p) & dia box (p => box p)
               => box dia p => dia box p)).

fml(tx30,20,-((box (dia q & (-p v -q)) => box box (dia q & (-p v -q)))
               & (box dia p => dia box p) => box dia p & box dia q =>
               dia (p & q))).

fml(tx31,10,-((box dia p & box dia -p => dia (p & -p)) => box dia p =>
               dia box p)).

fml(tx32,10,-((box dia p => dia box p) => box p => dia p)).

fml(tx33,10,-((box ((p v dia p) & (-p v dia -p)) => box box ((p v dia
               p) & (-p v dia -p))) & box (box (p & (p v dia p) & (-p
               v dia -p)) => box box (p & (p v dia p) & (-p v dia
               -p))) & box (box (-p & (p v dia p) & (-p v dia -p)) =>
               box box (-p & (p v dia p) & (-p v dia -p))) & (box dia
               p => dia box p) => box (p v dia p) => dia (p & box
               p))).

fml(tx34,10,-((box (p v dia p) => dia (p & box p)) => box dia p => dia
               box p)).

fml(tx35,10,-((box (box (p & box p) => p & box p) => box (p & box p))
               => box p => box box p)).

fml(tx36,10,-((box (box false => false) => box false) => box dia true
               => box false)).

fml(tx37,10,-((box (box p => p) => box p) => box (box p => p) => dia
               box p => box p)).

fml(tx38,10,-((box dia true => box false) & (box (box p => p) => dia
               box p => box p) => box (box p => p) => box p)).

fml(tx39,10,-((box (box (p & box (box p => p)) => p & box (box p =>
               p)) => box (p & box (box p => p))) & box box (box (box
               p => p) => box p) => box (box (p => box p) => p) => box
               p)).

fml(tx40,10,-((box (box p => box box p) & (box (box p => p) => dia box
               p => box p) => box (box (p => box p) => p) => dia box p
               => box p))).

fml(tx41,10,-((box (box (p => box p) => p) => box box (box (p => box
               p) => p)) & box (box p => box box p) & (box (box (p =>
               box p) => p) => dia box p => p) & (box (box ((p => box
               p) => box (p => box p)) => p => box p) => dia box (p =>
               box p) => p => box p) => box (box (p => box p) => p) =>
               dia box p => box p)).

fml(tx42,10,-((box p => p) & (box (box (p => box p) => p) => dia box p
               => box p) => box (box (p => box p) => p) => dia box p
               => p)).

fml(tx43,10,-((box (box p => p) & (box (box (p => box p) => p) => dia
               box p => p) => box (box (p => box p) => box p) => dia
               box p => p))).

fml(tx44,10,-((box (box (box (p => box p) => box p) => dia box p => p)
               => box (box (p => box p) => box p) => dia box p => p) &
               box (box (p => box p) => p => box p) & box (box (box (p
               => box p) => box p) => dia box p => p) => box (box (p
               => box p) => p) => dia box p => p)).

fml(tx45,20,-((box (box p => p) & (box (box (p => box p) => p) => box
               box (box (p => box p) => p)) & box (box p => box box p)
               & (box (box (p => box p) => p) => dia box p => p) &
               (box (box ((p => box p) => box (p => box p)) => p =>
               box p) => dia box (p => box p) => p => box p) => box
               (box (p => box p) => box p) => dia box p => box p))).

fml(tx46,10,-((box p => p) & (box (box (box (p => box p) => box p) =>
               dia box p => box p) => box (box (p => box p) => box p)
               => dia box p => box p) & box (box (p => box p) => p =>
               box p) & box (box (box (p => box p) => box p) => dia
               box p => box p) => box (box (p => box p) => p) => dia
               box p => p)).

fml(tx47,10,-((box (box (p => box p) => p) => dia box p => p) => box
               (box (p => box p) => p) => dia box p => p v box p)).

fml(tx48,10,-((box p => p) & (box (box (p => box p) => p) => dia box p
               => p v box p) => box (box (p => box p) => p) => dia box
               p => p)).

fml(tx49,10,-((box (box ((box (p => box p) => p) & (box (box (p => box
               p) => p) => box box (box (p => box p) => p)) => box
               ((box (p => box p) => p) & (box (box (p => box p) => p)
               => box box (box (p => box p) => p)))) => (box (p => box
               p) => p) & (box (box (p => box p) => p) => box box (box
               (p => box p) => p))) => (box (p => box p) => p) & (box
               (box (p => box p) => p) => box box (box (p => box p) =>
               p))) & box (box (box (p => box p) => p) => p) => box
               (box (p => box p) => p) => box p)).

fml(tx50,10,-((box p => p) & (box (box (box (p => box p) => p) => box
               p) => box (box (p => box p) => p) => box p) & box (box
               (box (p => box p) => p) => box p) => box (box (p => box
               p) => p) => p)).

fml(tx51,10,-((box (box (p => box p) => p) => p) & box (box (box (p =>
               box p) => p) => p) => box (box (p => box p) => box p)
               => p)).

fml(tx52,10,-((box (box (p => box p) => p => box p) & (box -box (box
               (p => box p) => p) => -box (box (p => box p) => p)) &
               (box (box (p => box p) => box p) => p) => box (box (p
               => box p) => p) => p))).

fml(tx53,10,-((box (box ((box (p => box p) => box p) & (box (box (p =>
               box p) => p) => p) & (box ((box (p => box p) => box p)
               & (box (box (p => box p) => p) => p)) => box box ((box
               (p => box p) => box p) & (box (box (p => box p) => p)
               => p))) => box ((box (p => box p) => box p) & (box (box
               (p => box p) => p) => p) & (box ((box (p => box p) =>
               box p) & (box (box (p => box p) => p) => p)) => box box
               ((box (p => box p) => box p) & (box (box (p => box p)
               => p) => p))))) => (box (p => box p) => box p) & (box
               (box (p => box p) => p) => p) & (box ((box (p => box p)
               => box p) & (box (box (p => box p) => p) => p)) => box
               box ((box (p => box p) => box p) & (box (box (p => box
               p) => p) => p)))) => (box (p => box p) => box p) & (box
               (box (p => box p) => p) => p) & (box ((box (p => box p)
               => box p) & (box (box (p => box p) => p) => p)) => box
               box ((box (p => box p) => box p) & (box (box (p => box
               p) => p) => p)))) & box (box (box (p => box p) => p) =>
               p) => box (box (p => box p) => box p) => box p)).

fml(tx54,10,-((box p => p) & box (box (p => box p) => p => box p) &
               (box (box (p => box p) => box p) => box p) => box (box
               (p => box p) => p) => p)).

fml(tx55,10,-((box (box (p => box p) => p) => p) & (box (box ((box (p
               => box p) => p) & (box (box (p => box p) => p) => box
               box (box (p => box p) => p)) => box ((box (p => box p)
               => p) & (box (box (p => box p) => p) => box box (box (p
               => box p) => p)))) => (box (p => box p) => p) & (box
               (box (p => box p) => p) => box box (box (p => box p) =>
               p))) => (box (p => box p) => p) & (box (box (p => box
               p) => p) => box box (box (p => box p) => p))) => box
               (box (p => box p) => p) => p v box p)).

fml(tx56,10,-((box p => p) & (box (box (box (p => box p) => p) => p v
               box p) => box (box (p => box p) => p) => p v box p) &
               box (box (box (p => box p) => p) => p v box p) => box
               (box (p => box p) => p) => p)).

fml(tx57,30,-((box (box ((box (p => box q) => box q) & (box (box (p =>
               box q) => box q) => box box (box (p => box q) => box
               q)) => box ((box (p => box q) => box q) & (box (box (p
               => box q) => box q) => box box (box (p => box q) => box
               q)))) => (box (p => box q) => box q) & (box (box (p =>
               box q) => box q) => box box (box (p => box q) => box
               q))) => (box (p => box q) => box q) & (box (box (p =>
               box q) => box q) => box box (box (p => box q) => box
               q))) & (box (box ((box ((p => box q) => box (p => box
               q)) => p => box q) & (box (box ((p => box q) => box (p
               => box q)) => p => box q) => box box (box ((p => box q)
               => box (p => box q)) => p => box q)) => box ((box ((p
               => box q) => box (p => box q)) => p => box q) & (box
               (box ((p => box q) => box (p => box q)) => p => box q)
               => box box (box ((p => box q) => box (p => box q)) => p
               => box q)))) => (box ((p => box q) => box (p => box q))
               => p => box q) & (box (box ((p => box q) => box (p =>
               box q)) => p => box q) => box box (box ((p => box q) =>
               box (p => box q)) => p => box q))) => (box ((p => box
               q) => box (p => box q)) => p => box q) & (box (box ((p
               => box q) => box (p => box q)) => p => box q) => box
               box (box ((p => box q) => box (p => box q)) => p => box
               q))) & box (box (box ((p => box q) => box (p => box q))
               => p => box q) => p => box q) => box (box (p => box q)
               => box q) & box (box (-p => box q) => box q) => box
               q)).

fml(tx58,10,-((box (box (p => box p) => p) => box (p => box p) => p) &
               box box (box (p => box p) => p => box p) & (box (box (p
               => box p) => p) => box box (box (p => box p) => p)) &
               box (box p => box box p) & (box (box (p => box (p =>
               box p)) => box (p => box p)) & box (box (-p => box (p
               => box p)) => box (p => box p)) => box (p => box p)) =>
               box (box (p => box p) => p) => p)).

fml(tx59,10,-((box (box (p => box p) => p) => p) => box p => p)).

fml(tx60,10,-((box (box (p & (box p => box box p) => box (p & (box p
               => box box p))) => p & (box p => box box p)) => p &
               (box p => box box p)) => box p => box box p)).

fml(tx61,10,-((box (box (dia -p => box dia -p) => dia -p) => dia -p) &
               (box (box (dia -p & (box dia -p => box box dia -p) =>
               box (dia -p & (box dia -p => box box dia -p))) => dia
               -p & (box dia -p => box box dia -p)) => dia -p & (box
               dia -p => box box dia -p)) & (box (box (-box (p => box
               p) & (box -box (p => box p) => box box -box (p => box
               p)) => box (-box (p => box p) & (box -box (p => box p)
               => box box -box (p => box p)))) => -box (p => box p) &
               (box -box (p => box p) => box box -box (p => box p)))
               => -box (p => box p) & (box -box (p => box p) => box
               box -box (p => box p))) & box (box (box (p => box p) =>
               p) => p) => box dia p => dia box p)).

fml(tx62,10,-((box (box (p => box p) => p) => p) => box (box (p => box
               p) => p) => dia box p => p)).

fml(tx63,10,-((box (box (p => box p) => p) => box p) => box (box (p =>
               box p) => p) => dia box p => box p)).

fml(tx64,10,-((box (box -p => -p) & (box dia p => dia box p) & (box
               (box (p => box p) => p) => dia box p => p) => box (box
               (p => box p) => p) => p))).

fml(tx65,10,-((dia box (box p => q) => (box p => q) => box (box p =>
               q)) => box (box p => q) v box (box q => p))).

fml(tx66,10,-((box dia box p => dia box p) & (dia box p => p => box p)
               => box dia box p => p => box p)).

fml(tx67,10,-((box box (box (box p => box box p) => box p => box box
               p) & box box (box -(box dia box p & box p) => -(box dia
               box p & box p)) & box (box p => box box p) & (box (box
               dia box p => -box p) v box (box -box p => dia box p)) &
               (box dia box p => p => box p) => dia box p => p => box
               p))).

fml(tx68,10,-((box dia p => dia p) & box (box -box dia p => -box dia
               p) & (box dia p => box box dia p) & box (dia box dia p
               => p => box p) => box dia p => dia box p)).

fml(tx69,10,-((box box (box -p => -p) & (dia box dia p => p => box p)
               => dia box p => p => box p))).

fml(tx70,10,-((box -box p => box box -box p) & box (box dia p => dia
               box p) & (dia box p => p => box p) => dia box dia p =>
               p => box p)).

fml(tx71,10,-((box box box (box p => p) & (dia box dia p => p => box
               p) & box (dia box dia -p => -p => box -p) => p => box
               (dia p => p)))).

fml(tx72,10,-((box (box (p => box p) => p) => box (p => box p) => p) &
               box (box (p & (box (p => box p) => p)) => box box (p &
               (box (p => box p) => p))) & (dia box (p => box p) => (p
               => box p) => box (p => box p)) => box (box (p => box p)
               => p) => dia box p => p)).

