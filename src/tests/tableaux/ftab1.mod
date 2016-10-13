module ftab1.
accumulate lmf-singlefoc.
accumulate lkf-kernel.
modalProblem "ModLeanTAP problem t1"
(((dia (-- p1)) !! (box (++ q1))) !! (dia ((++ p1) && (-- q1))))
(lmf-singlefoc-cert (lmf-singlefoc-state [] [])
  ((lmf-tree (lmf-singlefoc-node root none) [
    (lmf-tree (lmf-singlefoc-node (lind root) none) [
      (lmf-tree (lmf-singlefoc-node (rind (lind root)) none) [
        (lmf-tree (lmf-singlefoc-node (lind (lind root)) (rind (lind root))) [
          (lmf-tree (lmf-singlefoc-node (rind root) (rind (lind root))) [
            (lmf-tree (lmf-singlefoc-node (diaind ((rind root)) ((rind (lind root)))) none) [
              (lmf-tree (lmf-singlefoc-node (lind (diaind ((rind root)) ((rind (lind root))))) (diaind ((lind (lind root))) ((rind (lind root))))) [])
            , (lmf-tree (lmf-singlefoc-node (lind (rind (lind root))) (rind (diaind ((rind root)) ((rind (lind root)))))) [])
          ])
        ])
      ])
    ])
  ])
]))).
