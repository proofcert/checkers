sig modal-encoding.

accum_sig lkf-syntax.
accum_sig modal-syntax.

% We cannot change A to index, although for modal logic this is the case
% because types A and index seem not to be unifiable.
% Trying to debug it produced the two results

%  >>> all_kc (lmf-singlefoc-cert (lmf-singlefoc-state nil nil) (lmf-tree (lmf-singlefoc-node (rind (lind root)) none) (lmf-tree (lmf-singlefoc-node (lind (lind root)) (rind (lind root))) (lmf-tree (lmf-singlefoc-node (diaind (lind (lind root)) (rind (lind root))) none) (lmf-tree (lmf-singlefoc-node (rind root) (rind (lind root))) (lmf-tree (lmf-singlefoc-node (diaind (rind root) (rind (lind root))) none) (lmf-tree (lmf-singlefoc-node (lind (diaind (rind root) (rind (lind root)))) (diaind (lind (lind root)) (rind (lind root)))) nil :: lmf-tree (lmf-singlefoc-node (rind (diaind (rind root) (rind (lind root)))) none) (lmf-tree (lmf-singlefoc-node (lind (rind (lind root))) (rind (diaind (rind root) (rind (lind root))))) nil :: nil) :: nil) :: nil) :: nil) :: nil) :: nil))) _62312
%  >>> all_kc (lmf-singlefoc-cert (lmf-singlefoc-state nil nil) (lmf-tree (lmf-singlefoc-node (rind (lind root)) none) (lmf-tree (lmf-singlefoc-node (lind (lind root)) (rind (lind root))) (lmf-tree (lmf-singlefoc-node (diaind (lind (lind root)) (rind (lind root))) none) (lmf-tree (lmf-singlefoc-node (rind root) (rind (lind root))) (lmf-tree (lmf-singlefoc-node (diaind (rind root) (rind (lind root))) none) (lmf-tree (lmf-singlefoc-node (lind (diaind (rind root) (rind (lind root)))) (diaind (lind (lind root)) (rind (lind root)))) nil :: lmf-tree (lmf-singlefoc-node (rind (diaind (rind root) (rind (lind root)))) none) (lmf-tree (lmf-singlefoc-node (lind (rind (lind root))) (rind (diaind (rind root) (rind (lind root))))) nil :: nil) :: nil) :: nil) :: nil) :: nil) :: nil))) _62520
%  +++ all_kc (lmf-singlefoc-cert (lmf-singlefoc-state nil nil) (lmf-tree (lmf-singlefoc-node (rind (lind root)) none) (lmf-tree (lmf-singlefoc-node (lind (lind root)) (rind (lind root))) (lmf-tree (lmf-singlefoc-node (diaind (lind (lind root)) (rind (lind root))) none) (lmf-tree (lmf-singlefoc-node (rind root) (rind (lind root))) (lmf-tree (lmf-singlefoc-node (diaind (rind root) (rind (lind root))) none) (lmf-tree (lmf-singlefoc-node (lind (diaind (rind root) (rind (lind root)))) (diaind (lind (lind root)) (rind (lind root)))) nil :: lmf-tree (lmf-singlefoc-node (rind (diaind (rind root) (rind (lind root)))) none) (lmf-tree (lmf-singlefoc-node (lind (rind (lind root))) (rind (diaind (rind root) (rind (lind root))))) nil :: nil) :: nil) :: nil) :: nil) :: nil) :: nil)))
%     (W1\ lmf-singlefoc-cert (lmf-singlefoc-state (lind (rind (lind root)) :: nil) (pr (rind (lind root)) W1 :: nil)) (lmf-tree (lmf-singlefoc-node (lind (lind root)) (rind (lind root))) (lmf-tree (lmf-singlefoc-node (diaind (lind (lind root)) (rind (lind root))) none) (lmf-tree (lmf-singlefoc-node (rind root) (rind (lind root))) (lmf-tree (lmf-singlefoc-node (diaind (rind root) (rind (lind root))) none) (lmf-tree (lmf-singlefoc-node (lind (diaind (rind root) (rind (lind root)))) (diaind (lind (lind root)) (rind (lind root)))) nil :: lmf-tree (lmf-singlefoc-node (rind (diaind (rind root) (rind (lind root)))) none) (lmf-tree (lmf-singlefoc-node (lind (rind (lind root))) (rind (diaind (rind root) (rind (lind root))))) nil :: nil) :: nil) :: nil) :: nil) :: nil)))

% where the first line is the one with A replaced by worlds
% the second and third are the success of keeping A as A
% as can be seen, there is no difference between the two line and it still fails to unify the head of the rule and the certificate
% the reason should be that either A is getting instantiated with some other type than index (but then it should not compile, no?)
% or a bug in Teyjus where A is not instantiated with index.

% for the accessibility relation, we use the same 'rel' in all problems
type rel A -> A -> atm.

type modalToLK modform -> (A -> form) -> o.
% type modalToLK A -> modform -> form -> o.
type optdel (A -> form) -> (A -> form) -> o.
% type optdel form -> form -> o.
type zero, x, y, z A.
