module ex-lmfstar1.
accumulate lmf-star.
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



modalProblem "Problem: Axiom K for lmf-star"
((dia((++ p1) && (-- q1))) !! ((dia(-- p1)) !! (box (++ q1))))

% the first argument of lmf-star-cert is the initial state (H, future, map_index_label) defined as:
% H = [root]
% future = none
% map_index_label = [pr root root]

(lmf-star-cert (lmf-star-state [root] none [pr root root]) (lmf-multifoc-cert(lmf-singlefoc-cert (lmf-singlefoc-state [] [])
  (lmf-tree (lmf-star-node [root] none (lmf-multifoc-node 1 (lmf-singlefoc-node root none))) [

  lmf-tree (lmf-star-node [root] none (lmf-multifoc-node 2 (lmf-singlefoc-node (rind root) none))) [

  lmf-tree (lmf-star-node [root] none (lmf-multifoc-node 3 (lmf-singlefoc-node (rind (rind root)) none))) [

  lmf-tree (lmf-star-node [root] (rind (rind root)) (lmf-multifoc-node 4 (lmf-singlefoc-node (lind (rind root)) (rind (rind root))))) [

  lmf-tree (lmf-star-node [rind (rind root)] (rind (rind root)) (lmf-multifoc-node 4 (lmf-singlefoc-node (lind root) (rind (rind root))))) [

  lmf-tree (lmf-star-node [rind (rind root)] none (lmf-multifoc-node 5 (lmf-singlefoc-node (diaind (lind root) (rind (rind root))) none))) [

  % focuses on the delayed negative literal --p1 (only needed for a problem in the translation)
  lmf-tree (lmf-star-node [rind (rind root)] none (lmf-multifoc-node 6 (lmf-singlefoc-node (diaind (lind (rind root)) (rind (rind root))) none))) [

  lmf-tree (lmf-star-node [rind (rind root)] none (lmf-multifoc-node 7 (lmf-singlefoc-node (lind (diaind (lind root) (rind (rind root)))) (diaind (lind (rind
root)) (rind (rind root)))))) []],

  % focuses on the delayed negative literal --q1 (only needed for a problem in the translation)
  lmf-tree (lmf-star-node [rind (rind root)] none (lmf-multifoc-node 8 (lmf-singlefoc-node (rind (diaind (lind root) (rind (rind
root)))) none))) [

  lmf-tree (lmf-star-node [rind (rind root)] none (lmf-multifoc-node 9 (lmf-singlefoc-node (lind (rind (rind root))) (rind (diaind (lind root) (rind (rind
root))))))) []]

  ]

  ]

  ]

  ]

  ]

  ]
  )))).
