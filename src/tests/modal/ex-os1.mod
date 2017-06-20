module ex-os1.
accumulate ordinary-sequents.
accumulate lkf-kernel.
accumulate modal-encoding.

% Here I list each subformula of the example formula, with the corresponding node_index and multifocusing_index

% ((dia((++p1) && (--q1))) !! ((dia(--p1)) !! (box (++q1)))) --- root , 1

% (dia((++p1) && (--q1))) --- lind root , 4
% ((++p1) && (--q1)) --- diaind (lind root) (rind (rind root)) , 5
% (++p1) --- lind (diaind (lind root) (rind (rind root))) , 7
% (--q1) --- rind (diaind (lind root) (rind (rind root))) , 8

% ((dia(--p1)) !! (box (++q1))) --- rind root , 2
% (dia(--p1)) --- lind (rind root) , 4
% (box (++q1)) --- rind (rind root) , 3
% (--p1) --- diaind (lind (rind root)) (rind (rind root)) , 6
% (++q1) --- lind (rind (rind root)) , 9



modalProblem "Problem: Axiom K for ordinary-sequents"
[]
((dia((++ p1) && (-- q1))) !! ((dia(-- p1)) !! (box (++ q1))))

% the first argument of ordinary-sequent-cert is the initial state (H, future, map_index_label, MFI, SubIndexesList, BoxIndex_EigenVariable_Map_List) defined as:
% H = [root]
% future = none
% map_index_label = [pr root root]
% MFI = 0
% SubIndexesList = []
% BoxIndex_EigenVariable_Map_List = []

(ordinary-sequent-cert (ordinary-sequent-state [root] none [pr root root] 0 [] [])
  (lmf-tree (ordinary-sequent-node root [none]) [

  lmf-tree (ordinary-sequent-node (rind root) [none]) [

  lmf-tree (ordinary-sequent-node (rind (rind root)) [(lind (rind root)), (lind root)]) [

%  lmf-tree (ordinary-sequent-node [root] (rind (rind root)) (lmf-multifoc-node 4 (lmf-singlefoc-node (lind (rind root)) (rind (rind root))))) [

%  lmf-tree (lmf-star-node [rind (rind root)] (rind (rind root)) (lmf-multifoc-node 4 (lmf-singlefoc-node (lind root) (rind (rind root))))) [

  lmf-tree (ordinary-sequent-node (diaind (lind root) (rind (rind root))) [none]) [

  % focuses on the delayed negative literal --p1 (only needed for a problem in the translation)
  lmf-tree (ordinary-sequent-node (diaind (lind (rind root)) (rind (rind root))) [none]) [

  lmf-tree (ordinary-sequent-node (lind (diaind (lind root) (rind (rind root)))) [diaind (lind
(rind
root)) (rind (rind root))]) []],

  % focuses on the delayed negative literal --q1 (only needed for a problem in the translation)
  lmf-tree (ordinary-sequent-node (rind (diaind (lind root) (rind (rind
root)))) [none]) [

  lmf-tree (ordinary-sequent-node (lind (rind (rind root))) [(rind (diaind (lind root) (rind
(rind
root))))]) []]

  ]

  ]

  ]

  ]

  )).
