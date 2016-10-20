module ftab1-mf.
accumulate lmf-multifoc.
accumulate lkf-kernel.
accumulate modal-encoding.

modalProblem "ModLeanTAP problem t1 multifocus version"
(((dia (-- p1)) !! (box (++ q1))) !! (dia ((++ p1) && (-- q1))))
(lmf-multifoc-cert (lmf-singlefoc-state [] [])
  ((lmf-tree (lmf-multifoc-node 1 (lmf-singlefoc-node root none)) [
    (lmf-tree (lmf-multifoc-node 1 (lmf-singlefoc-node (lind root) none)) [
      (lmf-tree (lmf-multifoc-node 1 (lmf-singlefoc-node (rind (lind root)) none)) [
        (lmf-tree (lmf-multifoc-node 1 (lmf-singlefoc-node (lind (lind root)) (rind (lind root)))) [
          (lmf-tree (lmf-multifoc-node 1 (lmf-singlefoc-node (rind root) (rind (lind root)))) [
            (lmf-tree (lmf-multifoc-node 1 (lmf-singlefoc-node (diaind ((rind root)) ((rind (lind root)))) none)) [
              (lmf-tree (lmf-multifoc-node 1 (lmf-singlefoc-node (lind (diaind ((rind root)) ((rind (lind root))))) (diaind ((lind (lind root))) ((rind (lind root)))))) [])
            , (lmf-tree (lmf-multifoc-node 1 (lmf-singlefoc-node (lind (rind (lind root))) (rind (diaind ((rind root)) ((rind (lind root))))))) [])
          ])
        ])
      ])
    ])
  ])
]))).
