%{
  open Dectree
%}

%token DCT
%token EI LI RI BI NN
%token LP RP
%token LB RB
%token CM
%token EOF

%start < Dectree.dec_tree option > main

%%

main:
| EOF { None }
| v = dectree { Some v }

dectree:
| DCT LP ind1 = index1 CM ind2 = index2 CM LB lst = dectree_list RB RP { Dectree ( ind1 , ind2 , lst ) }

dectree_list:
| v = dectree CM rst = dectree_list { v :: rst}
| v = dectree { [v] }
| { [] }

index1:
| EI { Eind }
| LI LP ind = index1 RP { Lind ind }
| RI LP ind = index1 RP { Rind ind }
| BI LP ind1 = index1 CM ind2 = index1 RP { Bind ( ind1 , ind2 ) }

index2:
| NN { None }
| ind = index1 { Some ind }
